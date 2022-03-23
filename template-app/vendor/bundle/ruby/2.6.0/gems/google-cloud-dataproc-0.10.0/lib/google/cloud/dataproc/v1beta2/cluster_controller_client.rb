# Copyright 2020 Google LLC
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
#
# EDITING INSTRUCTIONS
# This file was generated from the file
# https://github.com/googleapis/googleapis/blob/master/google/cloud/dataproc/v1beta2/clusters.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/cloud/dataproc/v1beta2/clusters_pb"
require "google/cloud/dataproc/v1beta2/credentials"
require "google/cloud/dataproc/version"

module Google
  module Cloud
    module Dataproc
      module V1beta2
        # The ClusterControllerService provides methods to manage clusters
        # of Compute Engine instances.
        #
        # @!attribute [r] cluster_controller_stub
        #   @return [Google::Cloud::Dataproc::V1beta2::ClusterController::Stub]
        class ClusterControllerClient
          # @private
          attr_reader :cluster_controller_stub

          # The default address of the service.
          SERVICE_ADDRESS = "dataproc.googleapis.com".freeze

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 443

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          DEFAULT_TIMEOUT = 30

          PAGE_DESCRIPTORS = {
            "list_clusters" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "clusters")
          }.freeze

          private_constant :PAGE_DESCRIPTORS

          # The scopes needed to make gRPC calls to all of the methods defined in
          # this service.
          ALL_SCOPES = [
            "https://www.googleapis.com/auth/cloud-platform"
          ].freeze

          # @private
          class OperationsClient < Google::Longrunning::OperationsClient
            self::SERVICE_ADDRESS = ClusterControllerClient::SERVICE_ADDRESS
            self::GRPC_INTERCEPTORS = ClusterControllerClient::GRPC_INTERCEPTORS
          end

          # @param credentials [Google::Auth::Credentials, String, Hash, GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
          #   Provides the means for authenticating requests made by the client. This parameter can
          #   be many types.
          #   A `Google::Auth::Credentials` uses a the properties of its represented keyfile for
          #   authenticating requests made by this client.
          #   A `String` will be treated as the path to the keyfile to be used for the construction of
          #   credentials for this client.
          #   A `Hash` will be treated as the contents of a keyfile to be used for the construction of
          #   credentials for this client.
          #   A `GRPC::Core::Channel` will be used to make calls through.
          #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The channel credentials
          #   should already be composed with a `GRPC::Core::CallCredentials` object.
          #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc transforms the
          #   metadata for requests, generally, to give OAuth credentials.
          # @param scopes [Array<String>]
          #   The OAuth scopes for this service. This parameter is ignored if
          #   an updater_proc is supplied.
          # @param client_config [Hash]
          #   A Hash for call options for each method. See
          #   Google::Gax#construct_settings for the structure of
          #   this data. Falls back to the default config if not specified
          #   or the specified config is missing data points.
          # @param timeout [Numeric]
          #   The default timeout, in seconds, for calls made through this client.
          # @param metadata [Hash]
          #   Default metadata to be sent with each request. This can be overridden on a per call basis.
          # @param service_address [String]
          #   Override for the service hostname, or `nil` to leave as the default.
          # @param service_port [Integer]
          #   Override for the service port, or `nil` to leave as the default.
          # @param exception_transformer [Proc]
          #   An optional proc that intercepts any exceptions raised during an API call to inject
          #   custom error handling.
          def initialize \
              credentials: nil,
              scopes: ALL_SCOPES,
              client_config: {},
              timeout: DEFAULT_TIMEOUT,
              metadata: nil,
              service_address: nil,
              service_port: nil,
              exception_transformer: nil,
              lib_name: nil,
              lib_version: ""
            # These require statements are intentionally placed here to initialize
            # the gRPC module only when it's required.
            # See https://github.com/googleapis/toolkit/issues/446
            require "google/gax/grpc"
            require "google/cloud/dataproc/v1beta2/clusters_services_pb"

            credentials ||= Google::Cloud::Dataproc::V1beta2::Credentials.default

            @operations_client = OperationsClient.new(
              credentials: credentials,
              scopes: scopes,
              client_config: client_config,
              timeout: timeout,
              lib_name: lib_name,
              service_address: service_address,
              service_port: service_port,
              lib_version: lib_version,
              metadata: metadata,
            )

            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::Dataproc::V1beta2::Credentials.new(credentials).updater_proc
            end
            if credentials.is_a?(GRPC::Core::Channel)
              channel = credentials
            end
            if credentials.is_a?(GRPC::Core::ChannelCredentials)
              chan_creds = credentials
            end
            if credentials.is_a?(Proc)
              updater_proc = credentials
            end
            if credentials.is_a?(Google::Auth::Credentials)
              updater_proc = credentials.updater_proc
            end

            package_version = Google::Cloud::Dataproc::VERSION

            google_api_client = "gl-ruby/#{RUBY_VERSION}"
            google_api_client << " #{lib_name}/#{lib_version}" if lib_name
            google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
            google_api_client << " grpc/#{GRPC::VERSION}"
            google_api_client.freeze

            headers = { :"x-goog-api-client" => google_api_client }
            if credentials.respond_to?(:quota_project_id) && credentials.quota_project_id
              headers[:"x-goog-user-project"] = credentials.quota_project_id
            end
            headers.merge!(metadata) unless metadata.nil?
            client_config_file = Pathname.new(__dir__).join(
              "cluster_controller_client_config.json"
            )
            defaults = client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.cloud.dataproc.v1beta2.ClusterController",
                JSON.parse(f.read),
                client_config,
                Google::Gax::Grpc::STATUS_CODE_NAMES,
                timeout,
                page_descriptors: PAGE_DESCRIPTORS,
                errors: Google::Gax::Grpc::API_ERRORS,
                metadata: headers
              )
            end

            # Allow overriding the service path/port in subclasses.
            service_path = service_address || self.class::SERVICE_ADDRESS
            port = service_port || self.class::DEFAULT_SERVICE_PORT
            interceptors = self.class::GRPC_INTERCEPTORS
            @cluster_controller_stub = Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds: chan_creds,
              channel: channel,
              updater_proc: updater_proc,
              scopes: scopes,
              interceptors: interceptors,
              &Google::Cloud::Dataproc::V1beta2::ClusterController::Stub.method(:new)
            )

            @create_cluster = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:create_cluster),
              defaults["create_cluster"],
              exception_transformer: exception_transformer
            )
            @update_cluster = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:update_cluster),
              defaults["update_cluster"],
              exception_transformer: exception_transformer
            )
            @delete_cluster = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:delete_cluster),
              defaults["delete_cluster"],
              exception_transformer: exception_transformer
            )
            @get_cluster = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:get_cluster),
              defaults["get_cluster"],
              exception_transformer: exception_transformer
            )
            @list_clusters = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:list_clusters),
              defaults["list_clusters"],
              exception_transformer: exception_transformer
            )
            @diagnose_cluster = Google::Gax.create_api_call(
              @cluster_controller_stub.method(:diagnose_cluster),
              defaults["diagnose_cluster"],
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          # Creates a cluster in a project. The returned
          # {Google::Longrunning::Operation#metadata Operation#metadata} will be
          # [ClusterOperationMetadata](https://cloud.google.com/dataproc/docs/reference/rpc/google.cloud.dataproc.v1beta2#clusteroperationmetadata).
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project that the cluster
          #   belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param cluster [Google::Cloud::Dataproc::V1beta2::Cluster | Hash]
          #   Required. The cluster to create.
          #   A hash of the same form as `Google::Cloud::Dataproc::V1beta2::Cluster`
          #   can also be provided.
          # @param request_id [String]
          #   Optional. A unique id used to identify the request. If the server
          #   receives two {Google::Cloud::Dataproc::V1beta2::CreateClusterRequest CreateClusterRequest} requests  with the same
          #   id, then the second request will be ignored and the
          #   first {Google::Longrunning::Operation} created and stored in the backend
          #   is returned.
          #
          #   It is recommended to always set this value to a
          #   [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier).
          #
          #   The id must contain only letters (a-z, A-Z), numbers (0-9),
          #   underscores (_), and hyphens (-). The maximum length is 40 characters.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # TODO: Initialize `cluster`:
          #   cluster = {}
          #
          #   # Register a callback during the method call.
          #   operation = cluster_controller_client.create_cluster(project_id, region, cluster) do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Or use the return value to register a callback.
          #   operation.on_done do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Manually reload the operation.
          #   operation.reload!
          #
          #   # Or block until the operation completes, triggering callbacks on
          #   # completion.
          #   operation.wait_until_done!

          def create_cluster \
              project_id,
              region,
              cluster,
              request_id: nil,
              options: nil
            req = {
              project_id: project_id,
              region: region,
              cluster: cluster,
              request_id: request_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::CreateClusterRequest)
            operation = Google::Gax::Operation.new(
              @create_cluster.call(req, options),
              @operations_client,
              Google::Cloud::Dataproc::V1beta2::Cluster,
              Google::Cloud::Dataproc::V1beta2::ClusterOperationMetadata,
              call_options: options
            )
            operation.on_done { |operation| yield(operation) } if block_given?
            operation
          end

          # Updates a cluster in a project. The returned
          # {Google::Longrunning::Operation#metadata Operation#metadata} will be
          # [ClusterOperationMetadata](https://cloud.google.com/dataproc/docs/reference/rpc/google.cloud.dataproc.v1beta2#clusteroperationmetadata).
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project the
          #   cluster belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param cluster_name [String]
          #   Required. The cluster name.
          # @param cluster [Google::Cloud::Dataproc::V1beta2::Cluster | Hash]
          #   Required. The changes to the cluster.
          #   A hash of the same form as `Google::Cloud::Dataproc::V1beta2::Cluster`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Required. Specifies the path, relative to `Cluster`, of
          #   the field to update. For example, to change the number of workers
          #   in a cluster to 5, the `update_mask` parameter would be
          #   specified as `config.worker_config.num_instances`,
          #   and the `PATCH` request body would specify the new value, as follows:
          #
          #       {
          #         "config":{
          #           "workerConfig":{
          #             "numInstances":"5"
          #           }
          #         }
          #       }
          #
          #   Similarly, to change the number of preemptible workers in a cluster to 5,
          #   the `update_mask` parameter would be
          #   `config.secondary_worker_config.num_instances`, and the `PATCH` request
          #   body would be set as follows:
          #
          #       {
          #         "config":{
          #           "secondaryWorkerConfig":{
          #             "numInstances":"5"
          #           }
          #         }
          #       }
          #   <strong>Note:</strong> currently only the following fields can be updated:
          #
          #   <table>
          #   <tr>
          #   <td><strong>Mask</strong></td><td><strong>Purpose</strong></td>
          #   </tr>
          #   <tr>
          #   <td>labels</td><td>Updates labels</td>
          #   </tr>
          #   <tr>
          #   <td>config.worker_config.num_instances</td><td>Resize primary worker
          #   group</td>
          #   </tr>
          #   <tr>
          #   <td>config.secondary_worker_config.num_instances</td><td>Resize secondary
          #   worker group</td>
          #   </tr>
          #   <tr>
          #   <td>config.lifecycle_config.auto_delete_ttl</td><td>Reset MAX TTL
          #   duration</td>
          #   </tr>
          #   <tr>
          #   <td>config.lifecycle_config.auto_delete_time</td><td>Update MAX TTL
          #   deletion timestamp</td>
          #   </tr>
          #   <tr>
          #   <td>config.lifecycle_config.idle_delete_ttl</td><td>Update Idle TTL
          #   duration</td>
          #   </tr>
          #   <tr>
          #   <td>config.autoscaling_config.policy_uri</td><td>Use, stop using, or change
          #   autoscaling policies</td>
          #   </tr>
          #   </table>
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param graceful_decommission_timeout [Google::Protobuf::Duration | Hash]
          #   Optional. Timeout for graceful YARN decomissioning. Graceful
          #   decommissioning allows removing nodes from the cluster without
          #   interrupting jobs in progress. Timeout specifies how long to wait for jobs
          #   in progress to finish before forcefully removing nodes (and potentially
          #   interrupting jobs). Default timeout is 0 (for forceful decommission), and
          #   the maximum allowed timeout is 1 day (see JSON representation of
          #   [Duration](https://developers.google.com/protocol-buffers/docs/proto3#json)).
          #
          #   Only supported on Dataproc image versions 1.2 and higher.
          #   A hash of the same form as `Google::Protobuf::Duration`
          #   can also be provided.
          # @param request_id [String]
          #   Optional. A unique id used to identify the request. If the server
          #   receives two {Google::Cloud::Dataproc::V1beta2::UpdateClusterRequest UpdateClusterRequest} requests  with the same
          #   id, then the second request will be ignored and the
          #   first {Google::Longrunning::Operation} created and stored in the
          #   backend is returned.
          #
          #   It is recommended to always set this value to a
          #   [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier).
          #
          #   The id must contain only letters (a-z, A-Z), numbers (0-9),
          #   underscores (_), and hyphens (-). The maximum length is 40 characters.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # TODO: Initialize `cluster_name`:
          #   cluster_name = ''
          #
          #   # TODO: Initialize `cluster`:
          #   cluster = {}
          #
          #   # TODO: Initialize `update_mask`:
          #   update_mask = {}
          #
          #   # Register a callback during the method call.
          #   operation = cluster_controller_client.update_cluster(project_id, region, cluster_name, cluster, update_mask) do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Or use the return value to register a callback.
          #   operation.on_done do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Manually reload the operation.
          #   operation.reload!
          #
          #   # Or block until the operation completes, triggering callbacks on
          #   # completion.
          #   operation.wait_until_done!

          def update_cluster \
              project_id,
              region,
              cluster_name,
              cluster,
              update_mask,
              graceful_decommission_timeout: nil,
              request_id: nil,
              options: nil
            req = {
              project_id: project_id,
              region: region,
              cluster_name: cluster_name,
              cluster: cluster,
              update_mask: update_mask,
              graceful_decommission_timeout: graceful_decommission_timeout,
              request_id: request_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::UpdateClusterRequest)
            operation = Google::Gax::Operation.new(
              @update_cluster.call(req, options),
              @operations_client,
              Google::Cloud::Dataproc::V1beta2::Cluster,
              Google::Cloud::Dataproc::V1beta2::ClusterOperationMetadata,
              call_options: options
            )
            operation.on_done { |operation| yield(operation) } if block_given?
            operation
          end

          # Deletes a cluster in a project. The returned
          # {Google::Longrunning::Operation#metadata Operation#metadata} will be
          # [ClusterOperationMetadata](https://cloud.google.com/dataproc/docs/reference/rpc/google.cloud.dataproc.v1beta2#clusteroperationmetadata).
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project that the cluster
          #   belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param cluster_name [String]
          #   Required. The cluster name.
          # @param cluster_uuid [String]
          #   Optional. Specifying the `cluster_uuid` means the RPC should fail
          #   (with error NOT_FOUND) if cluster with specified UUID does not exist.
          # @param request_id [String]
          #   Optional. A unique id used to identify the request. If the server
          #   receives two {Google::Cloud::Dataproc::V1beta2::DeleteClusterRequest DeleteClusterRequest} requests  with the same
          #   id, then the second request will be ignored and the
          #   first {Google::Longrunning::Operation} created and stored in the
          #   backend is returned.
          #
          #   It is recommended to always set this value to a
          #   [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier).
          #
          #   The id must contain only letters (a-z, A-Z), numbers (0-9),
          #   underscores (_), and hyphens (-). The maximum length is 40 characters.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # TODO: Initialize `cluster_name`:
          #   cluster_name = ''
          #
          #   # Register a callback during the method call.
          #   operation = cluster_controller_client.delete_cluster(project_id, region, cluster_name) do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Or use the return value to register a callback.
          #   operation.on_done do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Manually reload the operation.
          #   operation.reload!
          #
          #   # Or block until the operation completes, triggering callbacks on
          #   # completion.
          #   operation.wait_until_done!

          def delete_cluster \
              project_id,
              region,
              cluster_name,
              cluster_uuid: nil,
              request_id: nil,
              options: nil
            req = {
              project_id: project_id,
              region: region,
              cluster_name: cluster_name,
              cluster_uuid: cluster_uuid,
              request_id: request_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::DeleteClusterRequest)
            operation = Google::Gax::Operation.new(
              @delete_cluster.call(req, options),
              @operations_client,
              Google::Protobuf::Empty,
              Google::Cloud::Dataproc::V1beta2::ClusterOperationMetadata,
              call_options: options
            )
            operation.on_done { |operation| yield(operation) } if block_given?
            operation
          end

          # Gets the resource representation for a cluster in a project.
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project that the cluster
          #   belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param cluster_name [String]
          #   Required. The cluster name.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Cloud::Dataproc::V1beta2::Cluster]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Cloud::Dataproc::V1beta2::Cluster]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # TODO: Initialize `cluster_name`:
          #   cluster_name = ''
          #   response = cluster_controller_client.get_cluster(project_id, region, cluster_name)

          def get_cluster \
              project_id,
              region,
              cluster_name,
              options: nil,
              &block
            req = {
              project_id: project_id,
              region: region,
              cluster_name: cluster_name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::GetClusterRequest)
            @get_cluster.call(req, options, &block)
          end

          # Lists all regions/\\{region}/clusters in a project.
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project that the cluster
          #   belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param filter [String]
          #   Optional.  A filter constraining the clusters to list. Filters are
          #   case-sensitive and have the following syntax:
          #
          #   field = value [AND [field = value]] ...
          #
          #   where **field** is one of `status.state`, `clusterName`, or `labels.[KEY]`,
          #   and `[KEY]` is a label key. **value** can be `*` to match all values.
          #   `status.state` can be one of the following: `ACTIVE`, `INACTIVE`,
          #   `CREATING`, `RUNNING`, `ERROR`, `DELETING`, or `UPDATING`. `ACTIVE`
          #   contains the `CREATING`, `UPDATING`, and `RUNNING` states. `INACTIVE`
          #   contains the `DELETING` and `ERROR` states.
          #   `clusterName` is the name of the cluster provided at creation time.
          #   Only the logical `AND` operator is supported; space-separated items are
          #   treated as having an implicit `AND` operator.
          #
          #   Example filter:
          #
          #   status.state = ACTIVE AND clusterName = mycluster
          #   AND labels.env = staging AND labels.starred = *
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Cloud::Dataproc::V1beta2::Cluster>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Cloud::Dataproc::V1beta2::Cluster>]
          #   An enumerable of Google::Cloud::Dataproc::V1beta2::Cluster instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # Iterate over all results.
          #   cluster_controller_client.list_clusters(project_id, region).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   cluster_controller_client.list_clusters(project_id, region).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_clusters \
              project_id,
              region,
              filter: nil,
              page_size: nil,
              options: nil,
              &block
            req = {
              project_id: project_id,
              region: region,
              filter: filter,
              page_size: page_size
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::ListClustersRequest)
            @list_clusters.call(req, options, &block)
          end

          # Gets cluster diagnostic information. The returned
          # {Google::Longrunning::Operation#metadata Operation#metadata} will be
          # [ClusterOperationMetadata](https://cloud.google.com/dataproc/docs/reference/rpc/google.cloud.dataproc.v1beta2#clusteroperationmetadata).
          # After the operation completes,
          # {Google::Longrunning::Operation#response Operation#response}
          # contains
          # {Google::Protobuf::Empty Empty}.
          #
          # @param project_id [String]
          #   Required. The ID of the Google Cloud Platform project that the cluster
          #   belongs to.
          # @param region [String]
          #   Required. The Dataproc region in which to handle the request.
          # @param cluster_name [String]
          #   Required. The cluster name.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @return [Google::Gax::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dataproc"
          #
          #   cluster_controller_client = Google::Cloud::Dataproc::ClusterController.new(version: :v1beta2)
          #
          #   # TODO: Initialize `project_id`:
          #   project_id = ''
          #
          #   # TODO: Initialize `region`:
          #   region = ''
          #
          #   # TODO: Initialize `cluster_name`:
          #   cluster_name = ''
          #
          #   # Register a callback during the method call.
          #   operation = cluster_controller_client.diagnose_cluster(project_id, region, cluster_name) do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Or use the return value to register a callback.
          #   operation.on_done do |op|
          #     raise op.results.message if op.error?
          #     op_results = op.results
          #     # Process the results.
          #
          #     metadata = op.metadata
          #     # Process the metadata.
          #   end
          #
          #   # Manually reload the operation.
          #   operation.reload!
          #
          #   # Or block until the operation completes, triggering callbacks on
          #   # completion.
          #   operation.wait_until_done!

          def diagnose_cluster \
              project_id,
              region,
              cluster_name,
              options: nil
            req = {
              project_id: project_id,
              region: region,
              cluster_name: cluster_name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dataproc::V1beta2::DiagnoseClusterRequest)
            operation = Google::Gax::Operation.new(
              @diagnose_cluster.call(req, options),
              @operations_client,
              Google::Protobuf::Empty,
              Google::Cloud::Dataproc::V1beta2::DiagnoseClusterResults,
              call_options: options
            )
            operation.on_done { |operation| yield(operation) } if block_given?
            operation
          end
        end
      end
    end
  end
end
