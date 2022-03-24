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
# https://github.com/googleapis/googleapis/blob/master/google/cloud/bigquery/datatransfer/v1/datatransfer.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"

require "google/cloud/bigquery/datatransfer/v1/datatransfer_pb"
require "google/cloud/bigquery/data_transfer/v1/credentials"
require "google/cloud/bigquery/data_transfer/version"

module Google
  module Cloud
    module Bigquery
      module DataTransfer
        module V1
          # The Google BigQuery Data Transfer Service API enables BigQuery users to
          # configure the transfer of their data from other Google Products into
          # BigQuery. This service contains methods that are end user exposed. It backs
          # up the frontend.
          #
          # @!attribute [r] data_transfer_service_stub
          #   @return [Google::Cloud::Bigquery::DataTransfer::V1::DataTransferService::Stub]
          class DataTransferServiceClient
            # @private
            attr_reader :data_transfer_service_stub

            # The default address of the service.
            SERVICE_ADDRESS = "bigquerydatatransfer.googleapis.com".freeze

            # The default port of the service.
            DEFAULT_SERVICE_PORT = 443

            # The default set of gRPC interceptors.
            GRPC_INTERCEPTORS = []

            DEFAULT_TIMEOUT = 30

            PAGE_DESCRIPTORS = {
              "list_data_sources" => Google::Gax::PageDescriptor.new(
                "page_token",
                "next_page_token",
                "data_sources"),
              "list_transfer_configs" => Google::Gax::PageDescriptor.new(
                "page_token",
                "next_page_token",
                "transfer_configs"),
              "list_transfer_runs" => Google::Gax::PageDescriptor.new(
                "page_token",
                "next_page_token",
                "transfer_runs"),
              "list_transfer_logs" => Google::Gax::PageDescriptor.new(
                "page_token",
                "next_page_token",
                "transfer_messages")
            }.freeze

            private_constant :PAGE_DESCRIPTORS

            # The scopes needed to make gRPC calls to all of the methods defined in
            # this service.
            ALL_SCOPES = [
              "https://www.googleapis.com/auth/cloud-platform"
            ].freeze


            DATA_SOURCE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/dataSources/{data_source}"
            )

            private_constant :DATA_SOURCE_PATH_TEMPLATE

            LOCATION_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/locations/{location}"
            )

            private_constant :LOCATION_PATH_TEMPLATE

            LOCATION_DATA_SOURCE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/locations/{location}/dataSources/{data_source}"
            )

            private_constant :LOCATION_DATA_SOURCE_PATH_TEMPLATE

            LOCATION_RUN_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/locations/{location}/transferConfigs/{transfer_config}/runs/{run}"
            )

            private_constant :LOCATION_RUN_PATH_TEMPLATE

            LOCATION_TRANSFER_CONFIG_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/locations/{location}/transferConfigs/{transfer_config}"
            )

            private_constant :LOCATION_TRANSFER_CONFIG_PATH_TEMPLATE

            PROJECT_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}"
            )

            private_constant :PROJECT_PATH_TEMPLATE

            PROJECT_DATA_SOURCE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/dataSources/{data_source}"
            )

            private_constant :PROJECT_DATA_SOURCE_PATH_TEMPLATE

            PROJECT_RUN_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/transferConfigs/{transfer_config}/runs/{run}"
            )

            private_constant :PROJECT_RUN_PATH_TEMPLATE

            PROJECT_TRANSFER_CONFIG_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/transferConfigs/{transfer_config}"
            )

            private_constant :PROJECT_TRANSFER_CONFIG_PATH_TEMPLATE

            RUN_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/transferConfigs/{transfer_config}/runs/{run}"
            )

            private_constant :RUN_PATH_TEMPLATE

            TRANSFER_CONFIG_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
              "projects/{project}/transferConfigs/{transfer_config}"
            )

            private_constant :TRANSFER_CONFIG_PATH_TEMPLATE

            # Returns a fully-qualified data_source resource name string.
            # @param project [String]
            # @param data_source [String]
            # @return [String]
            def self.data_source_path project, data_source
              DATA_SOURCE_PATH_TEMPLATE.render(
                :"project" => project,
                :"data_source" => data_source
              )
            end

            # Returns a fully-qualified location resource name string.
            # @param project [String]
            # @param location [String]
            # @return [String]
            def self.location_path project, location
              LOCATION_PATH_TEMPLATE.render(
                :"project" => project,
                :"location" => location
              )
            end

            # Returns a fully-qualified location_data_source resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param location [String]
            # @param data_source [String]
            # @return [String]
            def self.location_data_source_path project, location, data_source
              LOCATION_DATA_SOURCE_PATH_TEMPLATE.render(
                :"project" => project,
                :"location" => location,
                :"data_source" => data_source
              )
            end

            # Returns a fully-qualified location_run resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param location [String]
            # @param transfer_config [String]
            # @param run [String]
            # @return [String]
            def self.location_run_path project, location, transfer_config, run
              LOCATION_RUN_PATH_TEMPLATE.render(
                :"project" => project,
                :"location" => location,
                :"transfer_config" => transfer_config,
                :"run" => run
              )
            end

            # Returns a fully-qualified location_transfer_config resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param location [String]
            # @param transfer_config [String]
            # @return [String]
            def self.location_transfer_config_path project, location, transfer_config
              LOCATION_TRANSFER_CONFIG_PATH_TEMPLATE.render(
                :"project" => project,
                :"location" => location,
                :"transfer_config" => transfer_config
              )
            end

            # Returns a fully-qualified project resource name string.
            # @param project [String]
            # @return [String]
            def self.project_path project
              PROJECT_PATH_TEMPLATE.render(
                :"project" => project
              )
            end

            # Returns a fully-qualified project_data_source resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param data_source [String]
            # @return [String]
            def self.project_data_source_path project, data_source
              PROJECT_DATA_SOURCE_PATH_TEMPLATE.render(
                :"project" => project,
                :"data_source" => data_source
              )
            end

            # Returns a fully-qualified project_run resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param transfer_config [String]
            # @param run [String]
            # @return [String]
            def self.project_run_path project, transfer_config, run
              PROJECT_RUN_PATH_TEMPLATE.render(
                :"project" => project,
                :"transfer_config" => transfer_config,
                :"run" => run
              )
            end

            # Returns a fully-qualified project_transfer_config resource name string.
            # @deprecated Multi-pattern resource names will have unified creation and parsing helper functions.
            # This helper function will be deleted in the next major version.
            # @param project [String]
            # @param transfer_config [String]
            # @return [String]
            def self.project_transfer_config_path project, transfer_config
              PROJECT_TRANSFER_CONFIG_PATH_TEMPLATE.render(
                :"project" => project,
                :"transfer_config" => transfer_config
              )
            end

            # Returns a fully-qualified run resource name string.
            # @param project [String]
            # @param transfer_config [String]
            # @param run [String]
            # @return [String]
            def self.run_path project, transfer_config, run
              RUN_PATH_TEMPLATE.render(
                :"project" => project,
                :"transfer_config" => transfer_config,
                :"run" => run
              )
            end

            # Returns a fully-qualified transfer_config resource name string.
            # @param project [String]
            # @param transfer_config [String]
            # @return [String]
            def self.transfer_config_path project, transfer_config
              TRANSFER_CONFIG_PATH_TEMPLATE.render(
                :"project" => project,
                :"transfer_config" => transfer_config
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
              require "google/cloud/bigquery/datatransfer/v1/datatransfer_services_pb"

              credentials ||= Google::Cloud::Bigquery::DataTransfer::V1::Credentials.default

              if credentials.is_a?(String) || credentials.is_a?(Hash)
                updater_proc = Google::Cloud::Bigquery::DataTransfer::V1::Credentials.new(credentials).updater_proc
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

              package_version = Google::Cloud::Bigquery::DataTransfer::VERSION

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
                "data_transfer_service_client_config.json"
              )
              defaults = client_config_file.open do |f|
                Google::Gax.construct_settings(
                  "google.cloud.bigquery.datatransfer.v1.DataTransferService",
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
              @data_transfer_service_stub = Google::Gax::Grpc.create_stub(
                service_path,
                port,
                chan_creds: chan_creds,
                channel: channel,
                updater_proc: updater_proc,
                scopes: scopes,
                interceptors: interceptors,
                &Google::Cloud::Bigquery::DataTransfer::V1::DataTransferService::Stub.method(:new)
              )

              @get_data_source = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:get_data_source),
                defaults["get_data_source"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
              @list_data_sources = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:list_data_sources),
                defaults["list_data_sources"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @create_transfer_config = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:create_transfer_config),
                defaults["create_transfer_config"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @update_transfer_config = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:update_transfer_config),
                defaults["update_transfer_config"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'transfer_config.name' => request.transfer_config.name}
                end
              )
              @delete_transfer_config = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:delete_transfer_config),
                defaults["delete_transfer_config"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
              @get_transfer_config = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:get_transfer_config),
                defaults["get_transfer_config"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
              @list_transfer_configs = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:list_transfer_configs),
                defaults["list_transfer_configs"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @schedule_transfer_runs = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:schedule_transfer_runs),
                defaults["schedule_transfer_runs"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @start_manual_transfer_runs = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:start_manual_transfer_runs),
                defaults["start_manual_transfer_runs"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @get_transfer_run = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:get_transfer_run),
                defaults["get_transfer_run"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
              @delete_transfer_run = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:delete_transfer_run),
                defaults["delete_transfer_run"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
              @list_transfer_runs = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:list_transfer_runs),
                defaults["list_transfer_runs"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @list_transfer_logs = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:list_transfer_logs),
                defaults["list_transfer_logs"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'parent' => request.parent}
                end
              )
              @check_valid_creds = Google::Gax.create_api_call(
                @data_transfer_service_stub.method(:check_valid_creds),
                defaults["check_valid_creds"],
                exception_transformer: exception_transformer,
                params_extractor: proc do |request|
                  {'name' => request.name}
                end
              )
            end

            # Service calls

            # Retrieves a supported data source and returns its settings,
            # which can be used for UI rendering.
            #
            # @param name [String]
            #   Required. The field will contain name of the resource requested, for example:
            #   `projects/{project_id}/dataSources/{data_source_id}` or
            #   `projects/{project_id}/locations/{location_id}/dataSources/{data_source_id}`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::DataSource]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::DataSource]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_data_source_path("[PROJECT]", "[DATA_SOURCE]")
            #   response = data_transfer_client.get_data_source(formatted_name)

            def get_data_source \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::GetDataSourceRequest)
              @get_data_source.call(req, options, &block)
            end

            # Lists supported data sources and returns their settings,
            # which can be used for UI rendering.
            #
            # @param parent [String]
            #   Required. The BigQuery project id for which data sources should be returned.
            #   Must be in the form: `projects/{project_id}` or
            #   `projects/{project_id}/locations/{location_id}
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
            # @yieldparam result [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::DataSource>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::DataSource>]
            #   An enumerable of Google::Cloud::Bigquery::DataTransfer::V1::DataSource instances.
            #   See Google::Gax::PagedEnumerable documentation for other
            #   operations such as per-page iteration or access to the response
            #   object.
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_path("[PROJECT]")
            #
            #   # Iterate over all results.
            #   data_transfer_client.list_data_sources(formatted_parent).each do |element|
            #     # Process element.
            #   end
            #
            #   # Or iterate over results one page at a time.
            #   data_transfer_client.list_data_sources(formatted_parent).each_page do |page|
            #     # Process each page at a time.
            #     page.each do |element|
            #       # Process element.
            #     end
            #   end

            def list_data_sources \
                parent,
                page_size: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                page_size: page_size
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::ListDataSourcesRequest)
              @list_data_sources.call(req, options, &block)
            end

            # Creates a new data transfer configuration.
            #
            # @param parent [String]
            #   Required. The BigQuery project id where the transfer configuration should be created.
            #   Must be in the format projects/\\{project_id}/locations/\\{location_id} or
            #   projects/\\{project_id}. If specified location and location of the
            #   destination bigquery dataset do not match - the request will fail.
            # @param transfer_config [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig | Hash]
            #   Required. Data transfer configuration to create.
            #   A hash of the same form as `Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig`
            #   can also be provided.
            # @param authorization_code [String]
            #   Optional OAuth2 authorization code to use with this transfer configuration.
            #   This is required if new credentials are needed, as indicated by
            #   `CheckValidCreds`.
            #   In order to obtain authorization_code, please make a
            #   request to
            #   https://www.gstatic.com/bigquerydatatransfer/oauthz/auth?client_id=<datatransferapiclientid>&scope=<data_source_scopes>&redirect_uri=<redirect_uri>
            #
            #   * client_id should be OAuth client_id of BigQuery DTS API for the given
            #     data source returned by ListDataSources method.
            #   * data_source_scopes are the scopes returned by ListDataSources method.
            #   * redirect_uri is an optional parameter. If not specified, then
            #     authorization code is posted to the opener of authorization flow window.
            #     Otherwise it will be sent to the redirect uri. A special value of
            #     urn:ietf:wg:oauth:2.0:oob means that authorization code should be
            #     returned in the title bar of the browser, with the page text prompting
            #     the user to copy the code and paste it in the application.
            # @param version_info [String]
            #   Optional version info. If users want to find a very recent access token,
            #   that is, immediately after approving access, users have to set the
            #   version_info claim in the token request. To obtain the version_info, users
            #   must use the "none+gsession" response type. which be return a
            #   version_info back in the authorization response which be be put in a JWT
            #   claim in the token request.
            # @param service_account_name [String]
            #   Optional service account name. If this field is set, transfer config will
            #   be created with this service account credentials. It requires that
            #   requesting user calling this API has permissions to act as this service
            #   account.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_path("[PROJECT]")
            #
            #   # TODO: Initialize `transfer_config`:
            #   transfer_config = {}
            #   response = data_transfer_client.create_transfer_config(formatted_parent, transfer_config)

            def create_transfer_config \
                parent,
                transfer_config,
                authorization_code: nil,
                version_info: nil,
                service_account_name: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                transfer_config: transfer_config,
                authorization_code: authorization_code,
                version_info: version_info,
                service_account_name: service_account_name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::CreateTransferConfigRequest)
              @create_transfer_config.call(req, options, &block)
            end

            # Updates a data transfer configuration.
            # All fields must be set, even if they are not updated.
            #
            # @param transfer_config [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig | Hash]
            #   Required. Data transfer configuration to create.
            #   A hash of the same form as `Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig`
            #   can also be provided.
            # @param update_mask [Google::Protobuf::FieldMask | Hash]
            #   Required. Required list of fields to be updated in this request.
            #   A hash of the same form as `Google::Protobuf::FieldMask`
            #   can also be provided.
            # @param authorization_code [String]
            #   Optional OAuth2 authorization code to use with this transfer configuration.
            #   If it is provided, the transfer configuration will be associated with the
            #   authorizing user.
            #   In order to obtain authorization_code, please make a
            #   request to
            #   https://www.gstatic.com/bigquerydatatransfer/oauthz/auth?client_id=<datatransferapiclientid>&scope=<data_source_scopes>&redirect_uri=<redirect_uri>
            #
            #   * client_id should be OAuth client_id of BigQuery DTS API for the given
            #     data source returned by ListDataSources method.
            #   * data_source_scopes are the scopes returned by ListDataSources method.
            #   * redirect_uri is an optional parameter. If not specified, then
            #     authorization code is posted to the opener of authorization flow window.
            #     Otherwise it will be sent to the redirect uri. A special value of
            #     urn:ietf:wg:oauth:2.0:oob means that authorization code should be
            #     returned in the title bar of the browser, with the page text prompting
            #     the user to copy the code and paste it in the application.
            # @param version_info [String]
            #   Optional version info. If users want to find a very recent access token,
            #   that is, immediately after approving access, users have to set the
            #   version_info claim in the token request. To obtain the version_info, users
            #   must use the "none+gsession" response type. which be return a
            #   version_info back in the authorization response which be be put in a JWT
            #   claim in the token request.
            # @param service_account_name [String]
            #   Optional service account name. If this field is set and
            #   "service_account_name" is set in update_mask, transfer config will be
            #   updated to use this service account credentials. It requires that
            #   requesting user calling this API has permissions to act as this service
            #   account.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #
            #   # TODO: Initialize `transfer_config`:
            #   transfer_config = {}
            #
            #   # TODO: Initialize `update_mask`:
            #   update_mask = {}
            #   response = data_transfer_client.update_transfer_config(transfer_config, update_mask)

            def update_transfer_config \
                transfer_config,
                update_mask,
                authorization_code: nil,
                version_info: nil,
                service_account_name: nil,
                options: nil,
                &block
              req = {
                transfer_config: transfer_config,
                update_mask: update_mask,
                authorization_code: authorization_code,
                version_info: version_info,
                service_account_name: service_account_name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::UpdateTransferConfigRequest)
              @update_transfer_config.call(req, options, &block)
            end

            # Deletes a data transfer configuration,
            # including any associated transfer runs and logs.
            #
            # @param name [String]
            #   Required. The field will contain name of the resource requested, for example:
            #   `projects/{project_id}/transferConfigs/{config_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result []
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_transfer_config_path("[PROJECT]", "[TRANSFER_CONFIG]")
            #   data_transfer_client.delete_transfer_config(formatted_name)

            def delete_transfer_config \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::DeleteTransferConfigRequest)
              @delete_transfer_config.call(req, options, &block)
              nil
            end

            # Returns information about a data transfer config.
            #
            # @param name [String]
            #   Required. The field will contain name of the resource requested, for example:
            #   `projects/{project_id}/transferConfigs/{config_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_transfer_config_path("[PROJECT]", "[TRANSFER_CONFIG]")
            #   response = data_transfer_client.get_transfer_config(formatted_name)

            def get_transfer_config \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::GetTransferConfigRequest)
              @get_transfer_config.call(req, options, &block)
            end

            # Returns information about all data transfers in the project.
            #
            # @param parent [String]
            #   Required. The BigQuery project id for which data sources
            #   should be returned: `projects/{project_id}` or
            #   `projects/{project_id}/locations/{location_id}`
            # @param data_source_ids [Array<String>]
            #   When specified, only configurations of requested data sources are returned.
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
            # @yieldparam result [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig>]
            #   An enumerable of Google::Cloud::Bigquery::DataTransfer::V1::TransferConfig instances.
            #   See Google::Gax::PagedEnumerable documentation for other
            #   operations such as per-page iteration or access to the response
            #   object.
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_path("[PROJECT]")
            #
            #   # Iterate over all results.
            #   data_transfer_client.list_transfer_configs(formatted_parent).each do |element|
            #     # Process element.
            #   end
            #
            #   # Or iterate over results one page at a time.
            #   data_transfer_client.list_transfer_configs(formatted_parent).each_page do |page|
            #     # Process each page at a time.
            #     page.each do |element|
            #       # Process element.
            #     end
            #   end

            def list_transfer_configs \
                parent,
                data_source_ids: nil,
                page_size: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                data_source_ids: data_source_ids,
                page_size: page_size
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::ListTransferConfigsRequest)
              @list_transfer_configs.call(req, options, &block)
            end

            # Creates transfer runs for a time range [start_time, end_time].
            # For each date - or whatever granularity the data source supports - in the
            # range, one transfer run is created.
            # Note that runs are created per UTC time in the time range.
            # DEPRECATED: use StartManualTransferRuns instead.
            #
            # @param parent [String]
            #   Required. Transfer configuration name in the form:
            #   `projects/{project_id}/transferConfigs/{config_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}`.
            # @param start_time [Google::Protobuf::Timestamp | Hash]
            #   Required. Start time of the range of transfer runs. For example,
            #   `"2017-05-25T00:00:00+00:00"`.
            #   A hash of the same form as `Google::Protobuf::Timestamp`
            #   can also be provided.
            # @param end_time [Google::Protobuf::Timestamp | Hash]
            #   Required. End time of the range of transfer runs. For example,
            #   `"2017-05-30T00:00:00+00:00"`.
            #   A hash of the same form as `Google::Protobuf::Timestamp`
            #   can also be provided.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::ScheduleTransferRunsResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::ScheduleTransferRunsResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_transfer_config_path("[PROJECT]", "[TRANSFER_CONFIG]")
            #
            #   # TODO: Initialize `start_time`:
            #   start_time = {}
            #
            #   # TODO: Initialize `end_time`:
            #   end_time = {}
            #   response = data_transfer_client.schedule_transfer_runs(formatted_parent, start_time, end_time)

            def schedule_transfer_runs \
                parent,
                start_time,
                end_time,
                options: nil,
                &block
              req = {
                parent: parent,
                start_time: start_time,
                end_time: end_time
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::ScheduleTransferRunsRequest)
              @schedule_transfer_runs.call(req, options, &block)
            end

            # Start manual transfer runs to be executed now with schedule_time equal to
            # current time. The transfer runs can be created for a time range where the
            # run_time is between start_time (inclusive) and end_time (exclusive), or for
            # a specific run_time.
            #
            # @param parent [String]
            #   Transfer configuration name in the form:
            #   `projects/{project_id}/transferConfigs/{config_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}`.
            # @param requested_time_range [Google::Cloud::Bigquery::DataTransfer::V1::StartManualTransferRunsRequest::TimeRange | Hash]
            #   Time range for the transfer runs that should be started.
            #   A hash of the same form as `Google::Cloud::Bigquery::DataTransfer::V1::StartManualTransferRunsRequest::TimeRange`
            #   can also be provided.
            # @param requested_run_time [Google::Protobuf::Timestamp | Hash]
            #   Specific run_time for a transfer run to be started. The
            #   requested_run_time must not be in the future.
            #   A hash of the same form as `Google::Protobuf::Timestamp`
            #   can also be provided.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::StartManualTransferRunsResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::StartManualTransferRunsResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   response = data_transfer_client.start_manual_transfer_runs

            def start_manual_transfer_runs \
                parent: nil,
                requested_time_range: nil,
                requested_run_time: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                requested_time_range: requested_time_range,
                requested_run_time: requested_run_time
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::StartManualTransferRunsRequest)
              @start_manual_transfer_runs.call(req, options, &block)
            end

            # Returns information about the particular transfer run.
            #
            # @param name [String]
            #   Required. The field will contain name of the resource requested, for example:
            #   `projects/{project_id}/transferConfigs/{config_id}/runs/{run_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}/runs/{run_id}`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::TransferRun]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::TransferRun]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_run_path("[PROJECT]", "[TRANSFER_CONFIG]", "[RUN]")
            #   response = data_transfer_client.get_transfer_run(formatted_name)

            def get_transfer_run \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::GetTransferRunRequest)
              @get_transfer_run.call(req, options, &block)
            end

            # Deletes the specified transfer run.
            #
            # @param name [String]
            #   Required. The field will contain name of the resource requested, for example:
            #   `projects/{project_id}/transferConfigs/{config_id}/runs/{run_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}/runs/{run_id}`
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result []
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_run_path("[PROJECT]", "[TRANSFER_CONFIG]", "[RUN]")
            #   data_transfer_client.delete_transfer_run(formatted_name)

            def delete_transfer_run \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::DeleteTransferRunRequest)
              @delete_transfer_run.call(req, options, &block)
              nil
            end

            # Returns information about running and completed jobs.
            #
            # @param parent [String]
            #   Required. Name of transfer configuration for which transfer runs should be retrieved.
            #   Format of transfer configuration resource name is:
            #   `projects/{project_id}/transferConfigs/{config_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}`.
            # @param states [Array<Google::Cloud::Bigquery::DataTransfer::V1::TransferState>]
            #   When specified, only transfer runs with requested states are returned.
            # @param page_size [Integer]
            #   The maximum number of resources contained in the underlying API
            #   response. If page streaming is performed per-resource, this
            #   parameter does not affect the return value. If page streaming is
            #   performed per-page, this determines the maximum number of
            #   resources in a page.
            # @param run_attempt [Google::Cloud::Bigquery::DataTransfer::V1::ListTransferRunsRequest::RunAttempt]
            #   Indicates how run attempts are to be pulled.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferRun>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferRun>]
            #   An enumerable of Google::Cloud::Bigquery::DataTransfer::V1::TransferRun instances.
            #   See Google::Gax::PagedEnumerable documentation for other
            #   operations such as per-page iteration or access to the response
            #   object.
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_transfer_config_path("[PROJECT]", "[TRANSFER_CONFIG]")
            #
            #   # Iterate over all results.
            #   data_transfer_client.list_transfer_runs(formatted_parent).each do |element|
            #     # Process element.
            #   end
            #
            #   # Or iterate over results one page at a time.
            #   data_transfer_client.list_transfer_runs(formatted_parent).each_page do |page|
            #     # Process each page at a time.
            #     page.each do |element|
            #       # Process element.
            #     end
            #   end

            def list_transfer_runs \
                parent,
                states: nil,
                page_size: nil,
                run_attempt: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                states: states,
                page_size: page_size,
                run_attempt: run_attempt
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::ListTransferRunsRequest)
              @list_transfer_runs.call(req, options, &block)
            end

            # Returns user facing log messages for the data transfer run.
            #
            # @param parent [String]
            #   Required. Transfer run name in the form:
            #   `projects/{project_id}/transferConfigs/{config_id}/runs/{run_id}` or
            #   `projects/{project_id}/locations/{location_id}/transferConfigs/{config_id}/runs/{run_id}`
            # @param page_size [Integer]
            #   The maximum number of resources contained in the underlying API
            #   response. If page streaming is performed per-resource, this
            #   parameter does not affect the return value. If page streaming is
            #   performed per-page, this determines the maximum number of
            #   resources in a page.
            # @param message_types [Array<Google::Cloud::Bigquery::DataTransfer::V1::TransferMessage::MessageSeverity>]
            #   Message types to return. If not populated - INFO, WARNING and ERROR
            #   messages are returned.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferMessage>]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Gax::PagedEnumerable<Google::Cloud::Bigquery::DataTransfer::V1::TransferMessage>]
            #   An enumerable of Google::Cloud::Bigquery::DataTransfer::V1::TransferMessage instances.
            #   See Google::Gax::PagedEnumerable documentation for other
            #   operations such as per-page iteration or access to the response
            #   object.
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_parent = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_run_path("[PROJECT]", "[TRANSFER_CONFIG]", "[RUN]")
            #
            #   # Iterate over all results.
            #   data_transfer_client.list_transfer_logs(formatted_parent).each do |element|
            #     # Process element.
            #   end
            #
            #   # Or iterate over results one page at a time.
            #   data_transfer_client.list_transfer_logs(formatted_parent).each_page do |page|
            #     # Process each page at a time.
            #     page.each do |element|
            #       # Process element.
            #     end
            #   end

            def list_transfer_logs \
                parent,
                page_size: nil,
                message_types: nil,
                options: nil,
                &block
              req = {
                parent: parent,
                page_size: page_size,
                message_types: message_types
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::ListTransferLogsRequest)
              @list_transfer_logs.call(req, options, &block)
            end

            # Returns true if valid credentials exist for the given data source and
            # requesting user.
            # Some data sources doesn't support service account, so we need to talk to
            # them on behalf of the end user. This API just checks whether we have OAuth
            # token for the particular user, which is a pre-requisite before user can
            # create a transfer config.
            #
            # @param name [String]
            #   Required. The data source in the form:
            #   `projects/{project_id}/dataSources/{data_source_id}` or
            #   `projects/{project_id}/locations/{location_id}/dataSources/{data_source_id}`.
            # @param options [Google::Gax::CallOptions]
            #   Overrides the default settings for this call, e.g, timeout,
            #   retries, etc.
            # @yield [result, operation] Access the result along with the RPC operation
            # @yieldparam result [Google::Cloud::Bigquery::DataTransfer::V1::CheckValidCredsResponse]
            # @yieldparam operation [GRPC::ActiveCall::Operation]
            # @return [Google::Cloud::Bigquery::DataTransfer::V1::CheckValidCredsResponse]
            # @raise [Google::Gax::GaxError] if the RPC is aborted.
            # @example
            #   require "google/cloud/bigquery/data_transfer"
            #
            #   data_transfer_client = Google::Cloud::Bigquery::DataTransfer.new(version: :v1)
            #   formatted_name = Google::Cloud::Bigquery::DataTransfer::V1::DataTransferServiceClient.project_data_source_path("[PROJECT]", "[DATA_SOURCE]")
            #   response = data_transfer_client.check_valid_creds(formatted_name)

            def check_valid_creds \
                name,
                options: nil,
                &block
              req = {
                name: name
              }.delete_if { |_, v| v.nil? }
              req = Google::Gax::to_proto(req, Google::Cloud::Bigquery::DataTransfer::V1::CheckValidCredsRequest)
              @check_valid_creds.call(req, options, &block)
            end
          end
        end
      end
    end
  end
end
