# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/dns/property/base'

module Google
  module Dns
    module Data
      # A class to manage data for Quota for project.
      class ProjectQuota
        include Comparable

        attr_reader :managed_zones
        attr_reader :resource_records_per_rrset
        attr_reader :rrset_additions_per_change
        attr_reader :rrset_deletions_per_change
        attr_reader :rrsets_per_managed_zone
        attr_reader :total_rrdata_size_per_change

        def to_json(_arg = nil)
          {
            'managedZones' => managed_zones,
            'resourceRecordsPerRrset' => resource_records_per_rrset,
            'rrsetAdditionsPerChange' => rrset_additions_per_change,
            'rrsetDeletionsPerChange' => rrset_deletions_per_change,
            'rrsetsPerManagedZone' => rrsets_per_managed_zone,
            'totalRrdataSizePerChange' => total_rrdata_size_per_change
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            managed_zones: managed_zones,
            resource_records_per_rrset: resource_records_per_rrset,
            rrset_additions_per_change: rrset_additions_per_change,
            rrset_deletions_per_change: rrset_deletions_per_change,
            rrsets_per_managed_zone: rrsets_per_managed_zone,
            total_rrdata_size_per_change: total_rrdata_size_per_change
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? ProjectQuota
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? ProjectQuota
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        private

        def compare_fields(other)
          [
            { self: managed_zones, other: other.managed_zones },
            { self: resource_records_per_rrset, other: other.resource_records_per_rrset },
            { self: rrset_additions_per_change, other: other.rrset_additions_per_change },
            { self: rrset_deletions_per_change, other: other.rrset_deletions_per_change },
            { self: rrsets_per_managed_zone, other: other.rrsets_per_managed_zone },
            { self: total_rrdata_size_per_change, other: other.total_rrdata_size_per_change }
          ]
        end
      end

      # Manages a ProjectQuota nested object
      # Data is coming from the GCP API
      class ProjectQuotaApi < ProjectQuota
        def initialize(args)
          @managed_zones = Google::Dns::Property::Integer.api_munge(args['managedZones'])
          @resource_records_per_rrset =
            Google::Dns::Property::Integer.api_munge(args['resourceRecordsPerRrset'])
          @rrset_additions_per_change =
            Google::Dns::Property::Integer.api_munge(args['rrsetAdditionsPerChange'])
          @rrset_deletions_per_change =
            Google::Dns::Property::Integer.api_munge(args['rrsetDeletionsPerChange'])
          @rrsets_per_managed_zone =
            Google::Dns::Property::Integer.api_munge(args['rrsetsPerManagedZone'])
          @total_rrdata_size_per_change =
            Google::Dns::Property::Integer.api_munge(args['totalRrdataSizePerChange'])
        end
      end

      # Manages a ProjectQuota nested object
      # Data is coming from the Puppet manifest
      class ProjectQuotaCatalog < ProjectQuota
        def initialize(args)
          @managed_zones = Google::Dns::Property::Integer.unsafe_munge(args['managed_zones'])
          @resource_records_per_rrset =
            Google::Dns::Property::Integer.unsafe_munge(args['resource_records_per_rrset'])
          @rrset_additions_per_change =
            Google::Dns::Property::Integer.unsafe_munge(args['rrset_additions_per_change'])
          @rrset_deletions_per_change =
            Google::Dns::Property::Integer.unsafe_munge(args['rrset_deletions_per_change'])
          @rrsets_per_managed_zone =
            Google::Dns::Property::Integer.unsafe_munge(args['rrsets_per_managed_zone'])
          @total_rrdata_size_per_change =
            Google::Dns::Property::Integer.unsafe_munge(args['total_rrdata_size_per_change'])
        end
      end
    end

    module Property
      # A class to manage input to Quota for project.
      class ProjectQuota < Google::Dns::Property::Base
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::ProjectQuotaCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::ProjectQuotaApi.new(value)
        end
      end
    end
  end
end
