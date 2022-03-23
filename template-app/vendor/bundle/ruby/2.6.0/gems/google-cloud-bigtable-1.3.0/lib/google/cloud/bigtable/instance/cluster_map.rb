# frozen_string_literal: true

# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Cloud
    module Bigtable
      class Instance
        ##
        # Instance::ClusterMap is a hash with cluster ID keys and cluster configuration values.
        # It is used to create a cluster.
        #
        # @example
        #
        #  clusters = Google::Cloud::Bigtable::Instance::ClusterMap.new
        #
        #  clusters.add("cluster-1", "us-east1-b", nodes: 3, storage_type: :SSD)
        #
        #  # Or
        #  clusters.add("cluster-2", "us-east1-b")
        #
        class ClusterMap < DelegateClass(::Hash)
          # @private
          #
          # Creates a new Instance::ClusterMap with an hash of Cluster name and
          # cluster grpc instances.
          def initialize value = {}
            super value
          end

          ##
          # Adds a cluster to the cluster map.
          #
          # @param name [String] The unique identifier for the cluster.
          # @param location [String]
          #   The location where this cluster's nodes and storage reside. For best
          #   performance, clients should be located as close as possible to this
          #   cluster. Currently only zones are supported.
          # @param nodes [Integer] Number of nodes for the cluster. When creating
          #   an instance of type `:DEVELOPMENT`, `nodes` must not be set.
          # @param storage_type [Symbol]
          #   Valid values are:
          #   * `:SSD`(Flash (SSD) storage should be used),
          #   *`:HDD`(Magnetic drive (HDD) storage should be used)
          #
          #   If not set then default will set to `:STORAGE_TYPE_UNSPECIFIED`
          #
          def add name, location, nodes: nil, storage_type: nil
            attrs = {
              serve_nodes:          nodes,
              location:             location,
              default_storage_type: storage_type
            }.delete_if { |_, v| v.nil? }

            self[name] = Google::Bigtable::Admin::V2::Cluster.new attrs
          end
        end
      end
    end
  end
end
