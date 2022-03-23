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
# https://github.com/googleapis/googleapis/blob/master/google/monitoring/v3/uptime_service.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"

require "google/monitoring/v3/uptime_service_pb"
require "google/cloud/monitoring/v3/credentials"
require "google/cloud/monitoring/version"

module Google
  module Cloud
    module Monitoring
      module V3
        # The UptimeCheckService API is used to manage (list, create, delete, edit)
        # Uptime check configurations in the Stackdriver Monitoring product. An Uptime
        # check is a piece of configuration that determines which resources and
        # services to monitor for availability. These configurations can also be
        # configured interactively by navigating to the [Cloud Console]
        # (http://console.cloud.google.com), selecting the appropriate project,
        # clicking on "Monitoring" on the left-hand side to navigate to Stackdriver,
        # and then clicking on "Uptime".
        #
        # @!attribute [r] uptime_check_service_stub
        #   @return [Google::Monitoring::V3::UptimeCheckService::Stub]
        class UptimeCheckServiceClient
          # @private
          attr_reader :uptime_check_service_stub

          # The default address of the service.
          SERVICE_ADDRESS = "monitoring.googleapis.com".freeze

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 443

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          DEFAULT_TIMEOUT = 30

          PAGE_DESCRIPTORS = {
            "list_uptime_check_configs" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "uptime_check_configs"),
            "list_uptime_check_ips" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "uptime_check_ips")
          }.freeze

          private_constant :PAGE_DESCRIPTORS

          # The scopes needed to make gRPC calls to all of the methods defined in
          # this service.
          ALL_SCOPES = [
            "https://www.googleapis.com/auth/cloud-platform",
            "https://www.googleapis.com/auth/monitoring",
            "https://www.googleapis.com/auth/monitoring.read",
            "https://www.googleapis.com/auth/monitoring.write"
          ].freeze


          PROJECT_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}"
          )

          private_constant :PROJECT_PATH_TEMPLATE

          UPTIME_CHECK_CONFIG_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/uptimeCheckConfigs/{uptime_check_config}"
          )

          private_constant :UPTIME_CHECK_CONFIG_PATH_TEMPLATE

          # Returns a fully-qualified project resource name string.
          # @param project [String]
          # @return [String]
          def self.project_path project
            PROJECT_PATH_TEMPLATE.render(
              :"project" => project
            )
          end

          # Returns a fully-qualified uptime_check_config resource name string.
          # @param project [String]
          # @param uptime_check_config [String]
          # @return [String]
          def self.uptime_check_config_path project, uptime_check_config
            UPTIME_CHECK_CONFIG_PATH_TEMPLATE.render(
              :"project" => project,
              :"uptime_check_config" => uptime_check_config
            )
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
            require "google/monitoring/v3/uptime_service_services_pb"

            credentials ||= Google::Cloud::Monitoring::V3::Credentials.default

            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::Monitoring::V3::Credentials.new(credentials).updater_proc
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

            package_version = Google::Cloud::Monitoring::VERSION

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
              "uptime_check_service_client_config.json"
            )
            defaults = client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.monitoring.v3.UptimeCheckService",
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
            @uptime_check_service_stub = Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds: chan_creds,
              channel: channel,
              updater_proc: updater_proc,
              scopes: scopes,
              interceptors: interceptors,
              &Google::Monitoring::V3::UptimeCheckService::Stub.method(:new)
            )

            @list_uptime_check_configs = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:list_uptime_check_configs),
              defaults["list_uptime_check_configs"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @get_uptime_check_config = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:get_uptime_check_config),
              defaults["get_uptime_check_config"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @create_uptime_check_config = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:create_uptime_check_config),
              defaults["create_uptime_check_config"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @update_uptime_check_config = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:update_uptime_check_config),
              defaults["update_uptime_check_config"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'uptime_check_config.name' => request.uptime_check_config.name}
              end
            )
            @delete_uptime_check_config = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:delete_uptime_check_config),
              defaults["delete_uptime_check_config"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @list_uptime_check_ips = Google::Gax.create_api_call(
              @uptime_check_service_stub.method(:list_uptime_check_ips),
              defaults["list_uptime_check_ips"],
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          # Lists the existing valid Uptime check configurations for the project
          # (leaving out any invalid configurations).
          #
          # @param parent [String]
          #   Required. The project whose Uptime check configurations are listed. The format is:
          #
          #       projects/[PROJECT_ID_OR_NUMBER]
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
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Monitoring::V3::UptimeCheckConfig>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Monitoring::V3::UptimeCheckConfig>]
          #   An enumerable of Google::Monitoring::V3::UptimeCheckConfig instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #   formatted_parent = Google::Cloud::Monitoring::V3::UptimeCheckServiceClient.project_path("[PROJECT]")
          #
          #   # Iterate over all results.
          #   uptime_check_client.list_uptime_check_configs(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   uptime_check_client.list_uptime_check_configs(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_uptime_check_configs \
              parent,
              page_size: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              page_size: page_size
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::ListUptimeCheckConfigsRequest)
            @list_uptime_check_configs.call(req, options, &block)
          end

          # Gets a single Uptime check configuration.
          #
          # @param name [String]
          #   Required. The Uptime check configuration to retrieve. The format is:
          #
          #       projects/[PROJECT_ID_OR_NUMBER]/uptimeCheckConfigs/[UPTIME_CHECK_ID]
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Monitoring::V3::UptimeCheckConfig]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Monitoring::V3::UptimeCheckConfig]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #   formatted_name = Google::Cloud::Monitoring::V3::UptimeCheckServiceClient.uptime_check_config_path("[PROJECT]", "[UPTIME_CHECK_CONFIG]")
          #   response = uptime_check_client.get_uptime_check_config(formatted_name)

          def get_uptime_check_config \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::GetUptimeCheckConfigRequest)
            @get_uptime_check_config.call(req, options, &block)
          end

          # Creates a new Uptime check configuration.
          #
          # @param parent [String]
          #   Required. The project in which to create the Uptime check. The format is:
          #
          #       projects/[PROJECT_ID_OR_NUMBER]
          # @param uptime_check_config [Google::Monitoring::V3::UptimeCheckConfig | Hash]
          #   Required. The new Uptime check configuration.
          #   A hash of the same form as `Google::Monitoring::V3::UptimeCheckConfig`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Monitoring::V3::UptimeCheckConfig]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Monitoring::V3::UptimeCheckConfig]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #   formatted_parent = Google::Cloud::Monitoring::V3::UptimeCheckServiceClient.project_path("[PROJECT]")
          #
          #   # TODO: Initialize `uptime_check_config`:
          #   uptime_check_config = {}
          #   response = uptime_check_client.create_uptime_check_config(formatted_parent, uptime_check_config)

          def create_uptime_check_config \
              parent,
              uptime_check_config,
              options: nil,
              &block
            req = {
              parent: parent,
              uptime_check_config: uptime_check_config
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::CreateUptimeCheckConfigRequest)
            @create_uptime_check_config.call(req, options, &block)
          end

          # Updates an Uptime check configuration. You can either replace the entire
          # configuration with a new one or replace only certain fields in the current
          # configuration by specifying the fields to be updated via `updateMask`.
          # Returns the updated configuration.
          #
          # @param uptime_check_config [Google::Monitoring::V3::UptimeCheckConfig | Hash]
          #   Required. If an `updateMask` has been specified, this field gives
          #   the values for the set of fields mentioned in the `updateMask`. If an
          #   `updateMask` has not been given, this Uptime check configuration replaces
          #   the current configuration. If a field is mentioned in `updateMask` but
          #   the corresonding field is omitted in this partial Uptime check
          #   configuration, it has the effect of deleting/clearing the field from the
          #   configuration on the server.
          #
          #   The following fields can be updated: `display_name`,
          #   `http_check`, `tcp_check`, `timeout`, `content_matchers`, and
          #   `selected_regions`.
          #   A hash of the same form as `Google::Monitoring::V3::UptimeCheckConfig`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Optional. If present, only the listed fields in the current Uptime check
          #   configuration are updated with values from the new configuration. If this
          #   field is empty, then the current configuration is completely replaced with
          #   the new configuration.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Monitoring::V3::UptimeCheckConfig]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Monitoring::V3::UptimeCheckConfig]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #
          #   # TODO: Initialize `uptime_check_config`:
          #   uptime_check_config = {}
          #   response = uptime_check_client.update_uptime_check_config(uptime_check_config)

          def update_uptime_check_config \
              uptime_check_config,
              update_mask: nil,
              options: nil,
              &block
            req = {
              uptime_check_config: uptime_check_config,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::UpdateUptimeCheckConfigRequest)
            @update_uptime_check_config.call(req, options, &block)
          end

          # Deletes an Uptime check configuration. Note that this method will fail
          # if the Uptime check configuration is referenced by an alert policy or
          # other dependent configs that would be rendered invalid by the deletion.
          #
          # @param name [String]
          #   Required. The Uptime check configuration to delete. The format is:
          #
          #       projects/[PROJECT_ID_OR_NUMBER]/uptimeCheckConfigs/[UPTIME_CHECK_ID]
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #   formatted_name = Google::Cloud::Monitoring::V3::UptimeCheckServiceClient.uptime_check_config_path("[PROJECT]", "[UPTIME_CHECK_CONFIG]")
          #   uptime_check_client.delete_uptime_check_config(formatted_name)

          def delete_uptime_check_config \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::DeleteUptimeCheckConfigRequest)
            @delete_uptime_check_config.call(req, options, &block)
            nil
          end

          # Returns the list of IP addresses that checkers run from
          #
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
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Monitoring::V3::UptimeCheckIp>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Monitoring::V3::UptimeCheckIp>]
          #   An enumerable of Google::Monitoring::V3::UptimeCheckIp instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/monitoring"
          #
          #   uptime_check_client = Google::Cloud::Monitoring::UptimeCheck.new(version: :v3)
          #
          #   # Iterate over all results.
          #   uptime_check_client.list_uptime_check_ips.each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   uptime_check_client.list_uptime_check_ips.each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_uptime_check_ips \
              page_size: nil,
              options: nil,
              &block
            req = {
              page_size: page_size
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Monitoring::V3::ListUptimeCheckIpsRequest)
            @list_uptime_check_ips.call(req, options, &block)
          end
        end
      end
    end
  end
end
