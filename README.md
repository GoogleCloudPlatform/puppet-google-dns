# Google Cloud DNS Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/google/gdns.svg)](https://forge.puppetlabs.com/google/gdns)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](
    #module-description)
2. [Setup - The basics of getting started with Google Cloud DNS](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](
   #reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

This Puppet module manages the resource of Google Cloud DNS.
You can manage its resources using standard Puppet DSL and the module will,
under the hood, ensure the state described will be reflected in the Google
Cloud Platform resources.

## Setup

To install this module on your Puppet Master (or Puppet Client/Agent), use the
Puppet module installer:

    puppet module install google-gdns

Optionally you can install support to _all_ Google Cloud Platform products at
once by installing our "bundle" [`google-cloud`][bundle-forge] module:

    puppet module install google-cloud

## Usage

### Credentials

All Google Cloud Platform modules use an unified authentication mechanism,
provided by the [`google-gauth`][] module. Don't worry, it is automatically
installed when you install this module.

```puppet
gauth_credential { 'mycred':
  path     => $cred_path, # e.g. '/home/nelsonjr/my_account.json'
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/ndev.clouddns.readwrite',
  ],
}
```

Please refer to the [`google-gauth`][] module for further requirements, i.e.
required gems.

### Examples

#### `gdns_managed_zone`

```puppet
gdns_managed_zone { 'id-for-testzone-3-com':
  ensure      => present,
  name        => 'testzone-3-com',
  dns_name    => 'test.somewild-example.com.',
  description => 'Test Example Zone',
  project     => $project, # e.g. 'my-test-project'
  credential  => 'mycred',
}

```

#### `gdns_project`

```puppet
gdns_project { 'google.com:graphite-playground':
  credential                         => 'mycred',
  quota_managed_zones                => 10000,
  quota_total_rrdata_size_per_change => 100000,
}

```

#### `gdns_resource_record_set`

```puppet
gdns_managed_zone { 'some-managed-zone':
  ensure      => present,
  name        => 'testzone-4-com',
  dns_name    => 'testzone-4.com.',
  description => 'Test Example Zone',
  project     => $project, # e.g. 'my-test-project'
  credential  => 'mycred',
}

gdns_resource_record_set { 'www.testzone-4.com.':
  ensure       => present,
  managed_zone => 'some-managed-zone',
  type         => 'A',
  ttl          => 600,
  target       => [
    '10.1.2.3',
    '40.5.6.7',
    '80.9.10.11'
  ],
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

gdns_resource_record_set { 'sites.testzone-4.com.':
  ensure       => present,
  managed_zone => 'some-managed-zone',
  type         => 'CNAME',
  target       => 'www.testzone-4.com.',
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

gdns_resource_record_set { 'deleteme.testzone-4.com.':
  ensure       => absent,
  managed_zone => 'some-managed-zone',
  type         => 'A',
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

```


### Classes

#### Public classes

* [`gdns_managed_zone`][]:
    A zone is a subtree of the DNS namespace under one administrative
    responsibility. A ManagedZone is a resource that represents a DNS zone
    hosted by the Cloud DNS service.
* [`gdns_project`][]:
    A project resource. The project is a top level container for resources
    including Cloud DNS ManagedZones.
* [`gdns_resource_record_set`][]:
    A single DNS record that exists on a domain name (i.e. in a managed
    zone).
    This record defines the information about the domain and where the
    domain / subdomains direct to.
    The record will include the domain/subdomain name, a type (i.e. A, AAA,
    CAA, MX, CNAME, NS, etc)

### About output only properties

Some fields are output-only. It means you cannot set them because they are
provided by the Google Cloud Platform. Yet they are still useful to ensure the
value the API is assigning (or has assigned in the past) is still the value you
expect.

For example in a DNS the name servers are assigned by the Google Cloud DNS
service. Checking these values once created is useful to make sure your upstream
and/or root DNS masters are in sync.  Or if you decide to use the object ID,
e.g. the VM unique ID, for billing purposes. If the VM gets deleted and
recreated it will have a different ID, despite the name being the same. If that
detail is important to you you can verify that the ID of the object did not
change by asserting it in the manifest.

### Parameters

#### `gdns_managed_zone`

A zone is a subtree of the DNS namespace under one administrative
responsibility. A ManagedZone is a resource that represents a DNS zone
hosted by the Cloud DNS service.


#### Example

```puppet
gdns_managed_zone { 'id-for-testzone-3-com':
  ensure      => present,
  name        => 'testzone-3-com',
  dns_name    => 'test.somewild-example.com.',
  description => 'Test Example Zone',
  project     => $project, # e.g. 'my-test-project'
  credential  => 'mycred',
}

```

#### Reference

```puppet
gdns_managed_zone { 'id-of-resource':
  creation_time   => time,
  description     => string,
  dns_name        => string,
  id              => integer,
  name            => string,
  name_server_set => [
    string,
    ...
  ],
  name_servers    => [
    string,
    ...
  ],
  project         => string,
  credential      => reference to gauth_credential,
}
```

##### `description`

  A mutable string of at most 1024 characters associated with this
  resource for the user's convenience. Has no effect on the managed
  zone's function.

##### `dns_name`

  The DNS name of this managed zone, for instance "example.com.".

##### `name`

Required.  User assigned name for this resource.
  Must be unique within the project.

##### `name_server_set`

  Optionally specifies the NameServerSet for this ManagedZone. A
  NameServerSet is a set of DNS name servers that all host the same
  ManagedZones. Most users will leave this field unset.


##### Output-only properties

* `id`: Output only.
  Unique identifier for the resource; defined by the server.

* `name_servers`: Output only.
  Delegate your managed_zone to these virtual name servers;
  defined by the server

* `creation_time`: Output only.
  The time that this resource was created on the server.
  This is in RFC3339 text format.

#### `gdns_project`

A project resource. The project is a top level container for resources
including Cloud DNS ManagedZones.


#### Example

```puppet
gdns_project { 'google.com:graphite-playground':
  credential                         => 'mycred',
  quota_managed_zones                => 10000,
  quota_total_rrdata_size_per_change => 100000,
}

```

#### Reference

```puppet
gdns_project { 'id-of-resource':
  number     => integer,
  quota      => {
    managed_zones                => integer,
    resource_records_per_rrset   => integer,
    rrset_additions_per_change   => integer,
    rrset_deletions_per_change   => integer,
    rrsets_per_managed_zone      => integer,
    total_rrdata_size_per_change => integer,
  },
  project    => string,
  credential => reference to gauth_credential,
}
```


##### Output-only properties

* `number`: Output only.
  Unique numeric identifier for the resource; defined by the server.

* `quota`: Output only.
  Quota allowed in project

##### quota/managed_zones
Output only.  Maximum allowed number of managed zones in the project.

##### quota/resource_records_per_rrset
Output only.  Maximum allowed number of ResourceRecords per ResourceRecordSet.

##### quota/rrset_additions_per_change
Output only.  Maximum allowed number of ResourceRecordSets to add per
  ChangesCreateRequest.

##### quota/rrset_deletions_per_change
Output only.  Maximum allowed number of ResourceRecordSets to delete per
  ChangesCreateRequest.

##### quota/rrsets_per_managed_zone
Output only.  Maximum allowed number of ResourceRecordSets per zone in the
  project.

##### quota/total_rrdata_size_per_change
Output only.  Maximum allowed size for total rrdata in one ChangesCreateRequest
  in bytes.

#### `gdns_resource_record_set`

A single DNS record that exists on a domain name (i.e. in a managed zone).
This record defines the information about the domain and where the
domain / subdomains direct to.

The record will include the domain/subdomain name, a type (i.e. A, AAA,
CAA, MX, CNAME, NS, etc)


#### Example

```puppet
gdns_managed_zone { 'some-managed-zone':
  ensure      => present,
  name        => 'testzone-4-com',
  dns_name    => 'testzone-4.com.',
  description => 'Test Example Zone',
  project     => $project, # e.g. 'my-test-project'
  credential  => 'mycred',
}

gdns_resource_record_set { 'www.testzone-4.com.':
  ensure       => present,
  managed_zone => 'some-managed-zone',
  type         => 'A',
  ttl          => 600,
  target       => [
    '10.1.2.3',
    '40.5.6.7',
    '80.9.10.11'
  ],
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

gdns_resource_record_set { 'sites.testzone-4.com.':
  ensure       => present,
  managed_zone => 'some-managed-zone',
  type         => 'CNAME',
  target       => 'www.testzone-4.com.',
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

gdns_resource_record_set { 'deleteme.testzone-4.com.':
  ensure       => absent,
  managed_zone => 'some-managed-zone',
  type         => 'A',
  project      => $project, # e.g. 'my-test-project'
  credential   => 'mycred',
}

```

#### Reference

```puppet
gdns_resource_record_set { 'id-of-resource':
  managed_zone => reference to gdns_managed_zone,
  name         => string,
  target       => [
    string,
    ...
  ],
  ttl          => integer,
  type         => 'A', 'AAAA', 'CAA', 'CNAME', 'MX', 'NAPTR', 'NS', 'PTR', 'SOA', 'SPF', 'SRV' or 'TXT',
  project      => string,
  credential   => reference to gauth_credential,
}
```

##### `name`

Required.  For example, www.example.com.

##### `type`

Required.  One of valid DNS resource types.

##### `ttl`

  Number of seconds that this ResourceRecordSet can be cached by
  resolvers.

##### `target`

  As defined in RFC 1035 (section 5) and RFC 1034 (section 3.6.1)

##### `managed_zone`

Required.  Identifies the managed zone addressed by this request.
  Can be the managed zone name or id.



## Limitations

This module has been tested on:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13
* Windows Server 2008 R2, 2012 R2, 2012 R2 Core, 2016 R2, 2016 R2 Core

Testing on other platforms has been minimal and cannot be guaranteed.

## Development

### Automatically Generated Files

Some files in this package are automatically generated by
[Magic Modules][magic-modules].

We use a code compiler to produce this module in order to avoid repetitive tasks
and improve code quality. This means all Google Cloud Platform Puppet modules
use the same underlying authentication, logic, test generation, style checks,
etc.

Learn more about the way to change autogenerated files by reading the
[CONTRIBUTING.md][] file.

### Contributing

Contributions to this library are always welcome and highly encouraged.

See [CONTRIBUTING.md][] for more information on how to get
started.

### Running tests

This project contains tests for [rspec][], [rspec-puppet][] and [rubocop][] to
verify functionality. For detailed information on using these tools, please see
their respective documentation.

#### Testing quickstart: Ruby > 2.0.0

```
gem install bundler
bundle install
bundle exec rspec
bundle exec rubocop
```

#### Debugging Tests

In case you need to debug tests in this module you can set the following
variables to increase verbose output:

Variable                | Side Effect
------------------------|---------------------------------------------------
`PUPPET_HTTP_VERBOSE=1` | Prints network access information by Puppet provier.
`PUPPET_HTTP_DEBUG=1`   | Prints the payload of network calls being made.
`GOOGLE_HTTP_VERBOSE=1` | Prints debug related to the network calls being made.
`GOOGLE_HTTP_DEBUG=1`   | Prints the payload of network calls being made.

During test runs (using [rspec][]) you can also set:

Variable                | Side Effect
------------------------|---------------------------------------------------
`RSPEC_DEBUG=1`         | Prints debug related to the tests being run.
`RSPEC_HTTP_VERBOSE=1`  | Prints network expectations and access.

[magic-modules]: https://github.com/GoogleCloudPlatform/magic-modules
[CONTRIBUTING.md]: CONTRIBUTING.md
[bundle-forge]: https://forge.puppet.com/google/cloud
[`google-gauth`]: https://github.com/GoogleCloudPlatform/puppet-google-auth
[rspec]: http://rspec.info/
[rspec-puppet]: http://rspec-puppet.com/
[rubocop]: https://rubocop.readthedocs.io/en/latest/
[`gdns_managed_zone`]: #gdns_managed_zone
[`gdns_project`]: #gdns_project
[`gdns_resource_record_set`]: #gdns_resource_record_set
