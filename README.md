# Google Cloud DNS

#### Table of Contents

1. [Module Description - What the module does and why it is useful]
   (#module-description)
2. [Setup - The basics of getting started with Google Cloud DNS](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how]
   (#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

TODO(nelsonjr): Add documentation

## Setup

TODO(nelsonjr): Add documentation

## Usage

TODO(nelsonjr): Add documentation

## Reference

### Classes

#### Public classes

* [`gdns_managed_zone`](#gdns_managed_zone):
    A zone is a subtree of the DNS namespace under one administrative
    responsibility. A ManagedZone is a resource that represents a DNS zone
    hosted by the Cloud DNS service.
* [`gdns_project`](#gdns_project):
    A project resource. The project is a top level container for resources
    including Cloud DNS ManagedZones.
* [`gdns_resource_record_set`](#gdns_resource_record_set):
    A unit of data that will be returned by the DNS servers.

### Parameters

#### `gdns_managed_zone`

##### `description`

  A mutable string of at most 1024 characters associated with this
  resource for the user's convenience. Has no effect on the managed
  zone's function.

##### `dns_name`

  The DNS name of this managed zone, for instance "example.com.".

##### `id`

  Unique identifier for the resource; defined by the server.

##### `name`

  User assigned name for this resource.
  Must be unique within the project.

##### `name_servers`

  Delegate your managed_zone to these virtual name servers;
  defined by the server

##### `name_server_set`

  Optionally specifies the NameServerSet for this ManagedZone. A
  NameServerSet is a set of DNS name servers that all host the same
  ManagedZones. Most users will leave this field unset.

##### `creation_time`

  The time that this resource was created on the server.
  This is in RFC3339 text format.

#### `gdns_project`

##### `number`

  Unique numeric identifier for the resource; defined by the server.

##### `quota_managed_zones`

  Maximum allowed number of managed zones in the project.

##### `quota_resource_records_per_rrset`

  Maximum allowed number of ResourceRecords per ResourceRecordSet.

##### `quota_rrset_additions_per_change`

  Maximum allowed number of ResourceRecordSets to add per
  ChangesCreateRequest.

##### `quota_rrset_deletions_per_change`

  Maximum allowed number of ResourceRecordSets to delete per
  ChangesCreateRequest.

##### `quota_rrsets_per_managed_zone`

  Maximum allowed number of ResourceRecordSets per zone in the
  project.

##### `quota_total_rrdata_size_per_change`

  Maximum allowed size for total rrdata in one ChangesCreateRequest
  in bytes.

#### `gdns_resource_record_set`

##### `name`

  For example, www.example.com.

##### `type`

  One of valid DNS resource types.

##### `ttl`

  Number of seconds that this ResourceRecordSet can be cached by
  resolvers.

##### `target`

  As defined in RFC 1035 (section 5) and RFC 1034 (section 3.6.1)

##### `managed_zone`

  A reference to ManagedZone resource

## Limitations

This module has been tested on:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13

Testing on other platforms has been minimal and cannot be guaranteed.

## Development

TODO(nelsonjr): Add documentation
