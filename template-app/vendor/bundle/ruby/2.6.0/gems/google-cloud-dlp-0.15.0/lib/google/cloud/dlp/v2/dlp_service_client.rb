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
# https://github.com/googleapis/googleapis/blob/master/google/privacy/dlp/v2/dlp.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"

require "google/privacy/dlp/v2/dlp_pb"
require "google/cloud/dlp/v2/credentials"
require "google/cloud/dlp/version"

module Google
  module Cloud
    module Dlp
      module V2
        # The Cloud Data Loss Prevention (DLP) API is a service that allows clients
        # to detect the presence of Personally Identifiable Information (PII) and other
        # privacy-sensitive data in user-supplied, unstructured data streams, like text
        # blocks or images.
        # The service also includes methods for sensitive data redaction and
        # scheduling of data scans on Google Cloud Platform based data sets.
        #
        # To learn more about concepts and find how-to guides see
        # https://cloud.google.com/dlp/docs/.
        #
        # @!attribute [r] dlp_service_stub
        #   @return [Google::Privacy::Dlp::V2::DlpService::Stub]
        class DlpServiceClient
          # @private
          attr_reader :dlp_service_stub

          # The default address of the service.
          SERVICE_ADDRESS = "dlp.googleapis.com".freeze

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 443

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          DEFAULT_TIMEOUT = 30

          PAGE_DESCRIPTORS = {
            "list_inspect_templates" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "inspect_templates"),
            "list_deidentify_templates" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "deidentify_templates"),
            "list_dlp_jobs" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "jobs"),
            "list_job_triggers" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "job_triggers"),
            "list_stored_info_types" => Google::Gax::PageDescriptor.new(
              "page_token",
              "next_page_token",
              "stored_info_types")
          }.freeze

          private_constant :PAGE_DESCRIPTORS

          # The scopes needed to make gRPC calls to all of the methods defined in
          # this service.
          ALL_SCOPES = [
            "https://www.googleapis.com/auth/cloud-platform"
          ].freeze


          DLP_JOB_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/dlpJobs/{dlp_job}"
          )

          private_constant :DLP_JOB_PATH_TEMPLATE

          ORGANIZATION_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "organizations/{organization}"
          )

          private_constant :ORGANIZATION_PATH_TEMPLATE

          ORGANIZATION_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "organizations/{organization}/deidentifyTemplates/{deidentify_template}"
          )

          private_constant :ORGANIZATION_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE

          ORGANIZATION_INSPECT_TEMPLATE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "organizations/{organization}/inspectTemplates/{inspect_template}"
          )

          private_constant :ORGANIZATION_INSPECT_TEMPLATE_PATH_TEMPLATE

          ORGANIZATION_STORED_INFO_TYPE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "organizations/{organization}/storedInfoTypes/{stored_info_type}"
          )

          private_constant :ORGANIZATION_STORED_INFO_TYPE_PATH_TEMPLATE

          PROJECT_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}"
          )

          private_constant :PROJECT_PATH_TEMPLATE

          PROJECT_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/deidentifyTemplates/{deidentify_template}"
          )

          private_constant :PROJECT_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE

          PROJECT_INSPECT_TEMPLATE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/inspectTemplates/{inspect_template}"
          )

          private_constant :PROJECT_INSPECT_TEMPLATE_PATH_TEMPLATE

          PROJECT_JOB_TRIGGER_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/jobTriggers/{job_trigger}"
          )

          private_constant :PROJECT_JOB_TRIGGER_PATH_TEMPLATE

          PROJECT_STORED_INFO_TYPE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/storedInfoTypes/{stored_info_type}"
          )

          private_constant :PROJECT_STORED_INFO_TYPE_PATH_TEMPLATE

          # Returns a fully-qualified dlp_job resource name string.
          # @param project [String]
          # @param dlp_job [String]
          # @return [String]
          def self.dlp_job_path project, dlp_job
            DLP_JOB_PATH_TEMPLATE.render(
              :"project" => project,
              :"dlp_job" => dlp_job
            )
          end

          # Returns a fully-qualified organization resource name string.
          # @param organization [String]
          # @return [String]
          def self.organization_path organization
            ORGANIZATION_PATH_TEMPLATE.render(
              :"organization" => organization
            )
          end

          # Returns a fully-qualified organization_deidentify_template resource name string.
          # @param organization [String]
          # @param deidentify_template [String]
          # @return [String]
          def self.organization_deidentify_template_path organization, deidentify_template
            ORGANIZATION_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE.render(
              :"organization" => organization,
              :"deidentify_template" => deidentify_template
            )
          end

          # Returns a fully-qualified organization_inspect_template resource name string.
          # @param organization [String]
          # @param inspect_template [String]
          # @return [String]
          def self.organization_inspect_template_path organization, inspect_template
            ORGANIZATION_INSPECT_TEMPLATE_PATH_TEMPLATE.render(
              :"organization" => organization,
              :"inspect_template" => inspect_template
            )
          end

          # Returns a fully-qualified organization_stored_info_type resource name string.
          # @param organization [String]
          # @param stored_info_type [String]
          # @return [String]
          def self.organization_stored_info_type_path organization, stored_info_type
            ORGANIZATION_STORED_INFO_TYPE_PATH_TEMPLATE.render(
              :"organization" => organization,
              :"stored_info_type" => stored_info_type
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

          # Returns a fully-qualified project_deidentify_template resource name string.
          # @param project [String]
          # @param deidentify_template [String]
          # @return [String]
          def self.project_deidentify_template_path project, deidentify_template
            PROJECT_DEIDENTIFY_TEMPLATE_PATH_TEMPLATE.render(
              :"project" => project,
              :"deidentify_template" => deidentify_template
            )
          end

          # Returns a fully-qualified project_inspect_template resource name string.
          # @param project [String]
          # @param inspect_template [String]
          # @return [String]
          def self.project_inspect_template_path project, inspect_template
            PROJECT_INSPECT_TEMPLATE_PATH_TEMPLATE.render(
              :"project" => project,
              :"inspect_template" => inspect_template
            )
          end

          # Returns a fully-qualified project_job_trigger resource name string.
          # @param project [String]
          # @param job_trigger [String]
          # @return [String]
          def self.project_job_trigger_path project, job_trigger
            PROJECT_JOB_TRIGGER_PATH_TEMPLATE.render(
              :"project" => project,
              :"job_trigger" => job_trigger
            )
          end

          # Returns a fully-qualified project_stored_info_type resource name string.
          # @param project [String]
          # @param stored_info_type [String]
          # @return [String]
          def self.project_stored_info_type_path project, stored_info_type
            PROJECT_STORED_INFO_TYPE_PATH_TEMPLATE.render(
              :"project" => project,
              :"stored_info_type" => stored_info_type
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
            require "google/privacy/dlp/v2/dlp_services_pb"

            credentials ||= Google::Cloud::Dlp::V2::Credentials.default

            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::Dlp::V2::Credentials.new(credentials).updater_proc
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

            package_version = Google::Cloud::Dlp::VERSION

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
              "dlp_service_client_config.json"
            )
            defaults = client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.privacy.dlp.v2.DlpService",
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
            @dlp_service_stub = Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds: chan_creds,
              channel: channel,
              updater_proc: updater_proc,
              scopes: scopes,
              interceptors: interceptors,
              &Google::Privacy::Dlp::V2::DlpService::Stub.method(:new)
            )

            @inspect_content = Google::Gax.create_api_call(
              @dlp_service_stub.method(:inspect_content),
              defaults["inspect_content"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @redact_image = Google::Gax.create_api_call(
              @dlp_service_stub.method(:redact_image),
              defaults["redact_image"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @deidentify_content = Google::Gax.create_api_call(
              @dlp_service_stub.method(:deidentify_content),
              defaults["deidentify_content"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @reidentify_content = Google::Gax.create_api_call(
              @dlp_service_stub.method(:reidentify_content),
              defaults["reidentify_content"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @list_info_types = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_info_types),
              defaults["list_info_types"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'location_id' => request.location_id}
              end
            )
            @create_inspect_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:create_inspect_template),
              defaults["create_inspect_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @update_inspect_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:update_inspect_template),
              defaults["update_inspect_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @get_inspect_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:get_inspect_template),
              defaults["get_inspect_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @list_inspect_templates = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_inspect_templates),
              defaults["list_inspect_templates"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @delete_inspect_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:delete_inspect_template),
              defaults["delete_inspect_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @create_deidentify_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:create_deidentify_template),
              defaults["create_deidentify_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @update_deidentify_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:update_deidentify_template),
              defaults["update_deidentify_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @get_deidentify_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:get_deidentify_template),
              defaults["get_deidentify_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @list_deidentify_templates = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_deidentify_templates),
              defaults["list_deidentify_templates"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @delete_deidentify_template = Google::Gax.create_api_call(
              @dlp_service_stub.method(:delete_deidentify_template),
              defaults["delete_deidentify_template"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @create_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:create_dlp_job),
              defaults["create_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @list_dlp_jobs = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_dlp_jobs),
              defaults["list_dlp_jobs"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @get_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:get_dlp_job),
              defaults["get_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @delete_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:delete_dlp_job),
              defaults["delete_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @cancel_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:cancel_dlp_job),
              defaults["cancel_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @finish_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:finish_dlp_job),
              defaults["finish_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @hybrid_inspect_dlp_job = Google::Gax.create_api_call(
              @dlp_service_stub.method(:hybrid_inspect_dlp_job),
              defaults["hybrid_inspect_dlp_job"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @list_job_triggers = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_job_triggers),
              defaults["list_job_triggers"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @get_job_trigger = Google::Gax.create_api_call(
              @dlp_service_stub.method(:get_job_trigger),
              defaults["get_job_trigger"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @delete_job_trigger = Google::Gax.create_api_call(
              @dlp_service_stub.method(:delete_job_trigger),
              defaults["delete_job_trigger"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @hybrid_inspect_job_trigger = Google::Gax.create_api_call(
              @dlp_service_stub.method(:hybrid_inspect_job_trigger),
              defaults["hybrid_inspect_job_trigger"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @update_job_trigger = Google::Gax.create_api_call(
              @dlp_service_stub.method(:update_job_trigger),
              defaults["update_job_trigger"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @create_job_trigger = Google::Gax.create_api_call(
              @dlp_service_stub.method(:create_job_trigger),
              defaults["create_job_trigger"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @create_stored_info_type = Google::Gax.create_api_call(
              @dlp_service_stub.method(:create_stored_info_type),
              defaults["create_stored_info_type"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @update_stored_info_type = Google::Gax.create_api_call(
              @dlp_service_stub.method(:update_stored_info_type),
              defaults["update_stored_info_type"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @get_stored_info_type = Google::Gax.create_api_call(
              @dlp_service_stub.method(:get_stored_info_type),
              defaults["get_stored_info_type"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
            @list_stored_info_types = Google::Gax.create_api_call(
              @dlp_service_stub.method(:list_stored_info_types),
              defaults["list_stored_info_types"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'parent' => request.parent}
              end
            )
            @delete_stored_info_type = Google::Gax.create_api_call(
              @dlp_service_stub.method(:delete_stored_info_type),
              defaults["delete_stored_info_type"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'name' => request.name}
              end
            )
          end

          # Service calls

          # Finds potentially sensitive info in content.
          # This method has limits on input size, processing time, and output size.
          #
          # When no InfoTypes or CustomInfoTypes are specified in this request, the
          # system will automatically choose what detectors to run. By default this may
          # be all types, but may change over time as detectors are updated.
          #
          # For how to guides, see https://cloud.google.com/dlp/docs/inspecting-images
          # and https://cloud.google.com/dlp/docs/inspecting-text,
          #
          # @param parent [String]
          #   The parent resource name, for example projects/my-project-id.
          # @param inspect_config [Google::Privacy::Dlp::V2::InspectConfig | Hash]
          #   Configuration for the inspector. What specified here will override
          #   the template referenced by the inspect_template_name argument.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectConfig`
          #   can also be provided.
          # @param item [Google::Privacy::Dlp::V2::ContentItem | Hash]
          #   The item to inspect.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::ContentItem`
          #   can also be provided.
          # @param inspect_template_name [String]
          #   Template to use. Any configuration directly specified in
          #   inspect_config will override those set in the template. Singular fields
          #   that are set in this request will replace their corresponding fields in the
          #   template. Repeated fields are appended. Singular sub-messages and groups
          #   are recursively merged.
          # @param location_id [String]
          #   The geographic location to process content inspection. Reserved for future
          #   extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::InspectContentResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::InspectContentResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.inspect_content(formatted_parent)

          def inspect_content \
              parent,
              inspect_config: nil,
              item: nil,
              inspect_template_name: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              inspect_config: inspect_config,
              item: item,
              inspect_template_name: inspect_template_name,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::InspectContentRequest)
            @inspect_content.call(req, options, &block)
          end

          # Redacts potentially sensitive info from an image.
          # This method has limits on input size, processing time, and output size.
          # See https://cloud.google.com/dlp/docs/redacting-sensitive-data-images to
          # learn more.
          #
          # When no InfoTypes or CustomInfoTypes are specified in this request, the
          # system will automatically choose what detectors to run. By default this may
          # be all types, but may change over time as detectors are updated.
          #
          # @param parent [String]
          #   The parent resource name, for example projects/my-project-id.
          # @param location_id [String]
          #   The geographic location to process the request. Reserved for future
          #   extensions.
          # @param inspect_config [Google::Privacy::Dlp::V2::InspectConfig | Hash]
          #   Configuration for the inspector.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectConfig`
          #   can also be provided.
          # @param image_redaction_configs [Array<Google::Privacy::Dlp::V2::RedactImageRequest::ImageRedactionConfig | Hash>]
          #   The configuration for specifying what content to redact from images.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::RedactImageRequest::ImageRedactionConfig`
          #   can also be provided.
          # @param include_findings [true, false]
          #   Whether the response should include findings along with the redacted
          #   image.
          # @param byte_item [Google::Privacy::Dlp::V2::ByteContentItem | Hash]
          #   The content must be PNG, JPEG, SVG or BMP.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::ByteContentItem`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::RedactImageResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::RedactImageResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.redact_image(formatted_parent)

          def redact_image \
              parent,
              location_id: nil,
              inspect_config: nil,
              image_redaction_configs: nil,
              include_findings: nil,
              byte_item: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              location_id: location_id,
              inspect_config: inspect_config,
              image_redaction_configs: image_redaction_configs,
              include_findings: include_findings,
              byte_item: byte_item
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::RedactImageRequest)
            @redact_image.call(req, options, &block)
          end

          # De-identifies potentially sensitive info from a ContentItem.
          # This method has limits on input size and output size.
          # See https://cloud.google.com/dlp/docs/deidentify-sensitive-data to
          # learn more.
          #
          # When no InfoTypes or CustomInfoTypes are specified in this request, the
          # system will automatically choose what detectors to run. By default this may
          # be all types, but may change over time as detectors are updated.
          #
          # @param parent [String]
          #   The parent resource name, for example projects/my-project-id.
          # @param deidentify_config [Google::Privacy::Dlp::V2::DeidentifyConfig | Hash]
          #   Configuration for the de-identification of the content item.
          #   Items specified here will override the template referenced by the
          #   deidentify_template_name argument.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::DeidentifyConfig`
          #   can also be provided.
          # @param inspect_config [Google::Privacy::Dlp::V2::InspectConfig | Hash]
          #   Configuration for the inspector.
          #   Items specified here will override the template referenced by the
          #   inspect_template_name argument.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectConfig`
          #   can also be provided.
          # @param item [Google::Privacy::Dlp::V2::ContentItem | Hash]
          #   The item to de-identify. Will be treated as text.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::ContentItem`
          #   can also be provided.
          # @param inspect_template_name [String]
          #   Template to use. Any configuration directly specified in
          #   inspect_config will override those set in the template. Singular fields
          #   that are set in this request will replace their corresponding fields in the
          #   template. Repeated fields are appended. Singular sub-messages and groups
          #   are recursively merged.
          # @param deidentify_template_name [String]
          #   Template to use. Any configuration directly specified in
          #   deidentify_config will override those set in the template. Singular fields
          #   that are set in this request will replace their corresponding fields in the
          #   template. Repeated fields are appended. Singular sub-messages and groups
          #   are recursively merged.
          # @param location_id [String]
          #   The geographic location to process de-identification. Reserved for future
          #   extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DeidentifyContentResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DeidentifyContentResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.deidentify_content(formatted_parent)

          def deidentify_content \
              parent,
              deidentify_config: nil,
              inspect_config: nil,
              item: nil,
              inspect_template_name: nil,
              deidentify_template_name: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              deidentify_config: deidentify_config,
              inspect_config: inspect_config,
              item: item,
              inspect_template_name: inspect_template_name,
              deidentify_template_name: deidentify_template_name,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeidentifyContentRequest)
            @deidentify_content.call(req, options, &block)
          end

          # Re-identifies content that has been de-identified.
          # See
          # https://cloud.google.com/dlp/docs/pseudonymization#re-identification_in_free_text_code_example
          # to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name.
          # @param reidentify_config [Google::Privacy::Dlp::V2::DeidentifyConfig | Hash]
          #   Configuration for the re-identification of the content item.
          #   This field shares the same proto message type that is used for
          #   de-identification, however its usage here is for the reversal of the
          #   previous de-identification. Re-identification is performed by examining
          #   the transformations used to de-identify the items and executing the
          #   reverse. This requires that only reversible transformations
          #   be provided here. The reversible transformations are:
          #
          #   * `CryptoDeterministicConfig`
          #     * `CryptoReplaceFfxFpeConfig`
          #   A hash of the same form as `Google::Privacy::Dlp::V2::DeidentifyConfig`
          #   can also be provided.
          # @param inspect_config [Google::Privacy::Dlp::V2::InspectConfig | Hash]
          #   Configuration for the inspector.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectConfig`
          #   can also be provided.
          # @param item [Google::Privacy::Dlp::V2::ContentItem | Hash]
          #   The item to re-identify. Will be treated as text.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::ContentItem`
          #   can also be provided.
          # @param inspect_template_name [String]
          #   Template to use. Any configuration directly specified in
          #   `inspect_config` will override those set in the template. Singular fields
          #   that are set in this request will replace their corresponding fields in the
          #   template. Repeated fields are appended. Singular sub-messages and groups
          #   are recursively merged.
          # @param reidentify_template_name [String]
          #   Template to use. References an instance of `DeidentifyTemplate`.
          #   Any configuration directly specified in `reidentify_config` or
          #   `inspect_config` will override those set in the template. Singular fields
          #   that are set in this request will replace their corresponding fields in the
          #   template. Repeated fields are appended. Singular sub-messages and groups
          #   are recursively merged.
          # @param location_id [String]
          #   The geographic location to process content reidentification.  Reserved for
          #   future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::ReidentifyContentResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::ReidentifyContentResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.reidentify_content(formatted_parent)

          def reidentify_content \
              parent,
              reidentify_config: nil,
              inspect_config: nil,
              item: nil,
              inspect_template_name: nil,
              reidentify_template_name: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              reidentify_config: reidentify_config,
              inspect_config: inspect_config,
              item: item,
              inspect_template_name: inspect_template_name,
              reidentify_template_name: reidentify_template_name,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ReidentifyContentRequest)
            @reidentify_content.call(req, options, &block)
          end

          # Returns a list of the sensitive information types that the DLP API
          # supports. See https://cloud.google.com/dlp/docs/infotypes-reference to
          # learn more.
          #
          # @param language_code [String]
          #   BCP-47 language code for localized infoType friendly
          #   names. If omitted, or if localized strings are not available,
          #   en-US strings will be returned.
          # @param filter [String]
          #   filter to only return infoTypes supported by certain parts of the
          #   API. Defaults to supported_by=INSPECT.
          # @param location_id [String]
          #   The geographic location to list info types. Reserved for future
          #   extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::ListInfoTypesResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::ListInfoTypesResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   response = dlp_client.list_info_types

          def list_info_types \
              language_code: nil,
              filter: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              language_code: language_code,
              filter: filter,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListInfoTypesRequest)
            @list_info_types.call(req, options, &block)
          end

          # Creates an InspectTemplate for re-using frequently used configuration
          # for inspecting content, images, and storage.
          # See https://cloud.google.com/dlp/docs/creating-templates to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param inspect_template [Google::Privacy::Dlp::V2::InspectTemplate | Hash]
          #   Required. The InspectTemplate to create.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectTemplate`
          #   can also be provided.
          # @param template_id [String]
          #   The template id can contain uppercase and lowercase letters,
          #   numbers, and hyphens; that is, it must match the regular
          #   expression: `[a-zA-Z\\d-_]+`. The maximum length is 100
          #   characters. Can be empty to allow the system to generate one.
          # @param location_id [String]
          #   The geographic location to store the inspection template. Reserved for
          #   future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::InspectTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::InspectTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #   response = dlp_client.create_inspect_template(formatted_parent)

          def create_inspect_template \
              parent,
              inspect_template: nil,
              template_id: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              inspect_template: inspect_template,
              template_id: template_id,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CreateInspectTemplateRequest)
            @create_inspect_template.call(req, options, &block)
          end

          # Updates the InspectTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates to learn more.
          #
          # @param name [String]
          #   Required. Resource name of organization and inspectTemplate to be updated,
          #   for example `organizations/433245324/inspectTemplates/432452342` or
          #   projects/project-id/inspectTemplates/432452342.
          # @param inspect_template [Google::Privacy::Dlp::V2::InspectTemplate | Hash]
          #   New InspectTemplate value.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectTemplate`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Mask to control which fields get updated.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::InspectTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::InspectTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_inspect_template_path("[ORGANIZATION]", "[INSPECT_TEMPLATE]")
          #   response = dlp_client.update_inspect_template(formatted_name)

          def update_inspect_template \
              name,
              inspect_template: nil,
              update_mask: nil,
              options: nil,
              &block
            req = {
              name: name,
              inspect_template: inspect_template,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::UpdateInspectTemplateRequest)
            @update_inspect_template.call(req, options, &block)
          end

          # Gets an InspectTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates to learn more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and inspectTemplate to be read,
          #   for example `organizations/433245324/inspectTemplates/432452342` or
          #   projects/project-id/inspectTemplates/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::InspectTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::InspectTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   response = dlp_client.get_inspect_template

          def get_inspect_template \
              name: nil,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::GetInspectTemplateRequest)
            @get_inspect_template.call(req, options, &block)
          end

          # Lists InspectTemplates.
          # See https://cloud.google.com/dlp/docs/creating-templates to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param order_by [String]
          #   Comma separated list of fields to order by,
          #   followed by `asc` or `desc` postfix. This list is case-insensitive,
          #   default sorting order is ascending, redundant space characters are
          #   insignificant.
          #
          #   Example: `name asc,update_time, create_time desc`
          #
          #   Supported fields are:
          #
          #   * `create_time`: corresponds to time the template was created.
          #   * `update_time`: corresponds to time the template was last updated.
          #   * `name`: corresponds to template's name.
          #   * `display_name`: corresponds to template's display name.
          # @param location_id [String]
          #   The geographic location where inspection templates will be retrieved from.
          #   Use `-` for all locations. Reserved for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::InspectTemplate>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::InspectTemplate>]
          #   An enumerable of Google::Privacy::Dlp::V2::InspectTemplate instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #
          #   # Iterate over all results.
          #   dlp_client.list_inspect_templates(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   dlp_client.list_inspect_templates(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_inspect_templates \
              parent,
              page_size: nil,
              order_by: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              page_size: page_size,
              order_by: order_by,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListInspectTemplatesRequest)
            @list_inspect_templates.call(req, options, &block)
          end

          # Deletes an InspectTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates to learn more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and inspectTemplate to be
          #   deleted, for example `organizations/433245324/inspectTemplates/432452342`
          #   or projects/project-id/inspectTemplates/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_inspect_template_path("[ORGANIZATION]", "[INSPECT_TEMPLATE]")
          #   dlp_client.delete_inspect_template(formatted_name)

          def delete_inspect_template \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeleteInspectTemplateRequest)
            @delete_inspect_template.call(req, options, &block)
            nil
          end

          # Creates a DeidentifyTemplate for re-using frequently used configuration
          # for de-identifying content, images, and storage.
          # See https://cloud.google.com/dlp/docs/creating-templates-deid to learn
          # more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param deidentify_template [Google::Privacy::Dlp::V2::DeidentifyTemplate | Hash]
          #   Required. The DeidentifyTemplate to create.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::DeidentifyTemplate`
          #   can also be provided.
          # @param template_id [String]
          #   The template id can contain uppercase and lowercase letters,
          #   numbers, and hyphens; that is, it must match the regular
          #   expression: `[a-zA-Z\\d-_]+`. The maximum length is 100
          #   characters. Can be empty to allow the system to generate one.
          # @param location_id [String]
          #   The geographic location to store the deidentification template. Reserved
          #   for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #   response = dlp_client.create_deidentify_template(formatted_parent)

          def create_deidentify_template \
              parent,
              deidentify_template: nil,
              template_id: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              deidentify_template: deidentify_template,
              template_id: template_id,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CreateDeidentifyTemplateRequest)
            @create_deidentify_template.call(req, options, &block)
          end

          # Updates the DeidentifyTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates-deid to learn
          # more.
          #
          # @param name [String]
          #   Required. Resource name of organization and deidentify template to be
          #   updated, for example
          #   `organizations/433245324/deidentifyTemplates/432452342` or
          #   projects/project-id/deidentifyTemplates/432452342.
          # @param deidentify_template [Google::Privacy::Dlp::V2::DeidentifyTemplate | Hash]
          #   New DeidentifyTemplate value.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::DeidentifyTemplate`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Mask to control which fields get updated.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_deidentify_template_path("[ORGANIZATION]", "[DEIDENTIFY_TEMPLATE]")
          #   response = dlp_client.update_deidentify_template(formatted_name)

          def update_deidentify_template \
              name,
              deidentify_template: nil,
              update_mask: nil,
              options: nil,
              &block
            req = {
              name: name,
              deidentify_template: deidentify_template,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::UpdateDeidentifyTemplateRequest)
            @update_deidentify_template.call(req, options, &block)
          end

          # Gets a DeidentifyTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates-deid to learn
          # more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and deidentify template to be
          #   read, for example `organizations/433245324/deidentifyTemplates/432452342`
          #   or projects/project-id/deidentifyTemplates/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DeidentifyTemplate]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_deidentify_template_path("[ORGANIZATION]", "[DEIDENTIFY_TEMPLATE]")
          #   response = dlp_client.get_deidentify_template(formatted_name)

          def get_deidentify_template \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::GetDeidentifyTemplateRequest)
            @get_deidentify_template.call(req, options, &block)
          end

          # Lists DeidentifyTemplates.
          # See https://cloud.google.com/dlp/docs/creating-templates-deid to learn
          # more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param order_by [String]
          #   Comma separated list of fields to order by,
          #   followed by `asc` or `desc` postfix. This list is case-insensitive,
          #   default sorting order is ascending, redundant space characters are
          #   insignificant.
          #
          #   Example: `name asc,update_time, create_time desc`
          #
          #   Supported fields are:
          #
          #   * `create_time`: corresponds to time the template was created.
          #   * `update_time`: corresponds to time the template was last updated.
          #   * `name`: corresponds to template's name.
          #   * `display_name`: corresponds to template's display name.
          # @param location_id [String]
          #   The geographic location where deidentifications templates will be retrieved
          #   from. Use `-` for all locations. Reserved for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::DeidentifyTemplate>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::DeidentifyTemplate>]
          #   An enumerable of Google::Privacy::Dlp::V2::DeidentifyTemplate instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #
          #   # Iterate over all results.
          #   dlp_client.list_deidentify_templates(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   dlp_client.list_deidentify_templates(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_deidentify_templates \
              parent,
              page_size: nil,
              order_by: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              page_size: page_size,
              order_by: order_by,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListDeidentifyTemplatesRequest)
            @list_deidentify_templates.call(req, options, &block)
          end

          # Deletes a DeidentifyTemplate.
          # See https://cloud.google.com/dlp/docs/creating-templates-deid to learn
          # more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and deidentify template to be
          #   deleted, for example
          #   `organizations/433245324/deidentifyTemplates/432452342` or
          #   projects/project-id/deidentifyTemplates/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_deidentify_template_path("[ORGANIZATION]", "[DEIDENTIFY_TEMPLATE]")
          #   dlp_client.delete_deidentify_template(formatted_name)

          def delete_deidentify_template \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeleteDeidentifyTemplateRequest)
            @delete_deidentify_template.call(req, options, &block)
            nil
          end

          # Creates a new job to inspect storage or calculate risk metrics.
          # See https://cloud.google.com/dlp/docs/inspecting-storage and
          # https://cloud.google.com/dlp/docs/compute-risk-analysis to learn more.
          #
          # When no InfoTypes or CustomInfoTypes are specified in inspect jobs, the
          # system will automatically choose what detectors to run. By default this may
          # be all types, but may change over time as detectors are updated.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id.
          # @param inspect_job [Google::Privacy::Dlp::V2::InspectJobConfig | Hash]
          #   Set to control what and how to inspect.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::InspectJobConfig`
          #   can also be provided.
          # @param risk_job [Google::Privacy::Dlp::V2::RiskAnalysisJobConfig | Hash]
          #   Set to choose what metric to calculate.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::RiskAnalysisJobConfig`
          #   can also be provided.
          # @param job_id [String]
          #   The job id can contain uppercase and lowercase letters,
          #   numbers, and hyphens; that is, it must match the regular
          #   expression: `[a-zA-Z\\d-_]+`. The maximum length is 100
          #   characters. Can be empty to allow the system to generate one.
          # @param location_id [String]
          #   The geographic location to store and process the job. Reserved for
          #   future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DlpJob]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DlpJob]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.create_dlp_job(formatted_parent)

          def create_dlp_job \
              parent,
              inspect_job: nil,
              risk_job: nil,
              job_id: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              inspect_job: inspect_job,
              risk_job: risk_job,
              job_id: job_id,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CreateDlpJobRequest)
            @create_dlp_job.call(req, options, &block)
          end

          # Lists DlpJobs that match the specified filter in the request.
          # See https://cloud.google.com/dlp/docs/inspecting-storage and
          # https://cloud.google.com/dlp/docs/compute-risk-analysis to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id.
          # @param filter [String]
          #   Allows filtering.
          #
          #   Supported syntax:
          #
          #   * Filter expressions are made up of one or more restrictions.
          #   * Restrictions can be combined by `AND` or `OR` logical operators. A
          #     sequence of restrictions implicitly uses `AND`.
          #   * A restriction has the form of `{field} {operator} {value}`.
          #   * Supported fields/values for inspect jobs:
          #     * `state` - PENDING|RUNNING|CANCELED|FINISHED|FAILED
          #       * `inspected_storage` - DATASTORE|CLOUD_STORAGE|BIGQUERY
          #       * `trigger_name` - The resource name of the trigger that created job.
          #       * 'end_time` - Corresponds to time the job finished.
          #       * 'start_time` - Corresponds to time the job finished.
          #     * Supported fields for risk analysis jobs:
          #       * `state` - RUNNING|CANCELED|FINISHED|FAILED
          #       * 'end_time` - Corresponds to time the job finished.
          #       * 'start_time` - Corresponds to time the job finished.
          #     * The operator must be `=` or `!=`.
          #
          #     Examples:
          #
          #   * inspected_storage = cloud_storage AND state = done
          #   * inspected_storage = cloud_storage OR inspected_storage = bigquery
          #   * inspected_storage = cloud_storage AND (state = done OR state = canceled)
          #   * end_time > \"2017-12-12T00:00:00+00:00\"
          #
          #   The length of this field should be no more than 500 characters.
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param type [Google::Privacy::Dlp::V2::DlpJobType]
          #   The type of job. Defaults to `DlpJobType.INSPECT`
          # @param order_by [String]
          #   Comma separated list of fields to order by,
          #   followed by `asc` or `desc` postfix. This list is case-insensitive,
          #   default sorting order is ascending, redundant space characters are
          #   insignificant.
          #
          #   Example: `name asc, end_time asc, create_time desc`
          #
          #   Supported fields are:
          #
          #   * `create_time`: corresponds to time the job was created.
          #   * `end_time`: corresponds to time the job ended.
          #   * `name`: corresponds to job's name.
          #   * `state`: corresponds to `state`
          # @param location_id [String]
          #   The geographic location where jobs will be retrieved from.
          #   Use `-` for all locations. Reserved for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::DlpJob>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::DlpJob>]
          #   An enumerable of Google::Privacy::Dlp::V2::DlpJob instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #
          #   # Iterate over all results.
          #   dlp_client.list_dlp_jobs(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   dlp_client.list_dlp_jobs(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_dlp_jobs \
              parent,
              filter: nil,
              page_size: nil,
              type: nil,
              order_by: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              filter: filter,
              page_size: page_size,
              type: type,
              order_by: order_by,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListDlpJobsRequest)
            @list_dlp_jobs.call(req, options, &block)
          end

          # Gets the latest state of a long-running DlpJob.
          # See https://cloud.google.com/dlp/docs/inspecting-storage and
          # https://cloud.google.com/dlp/docs/compute-risk-analysis to learn more.
          #
          # @param name [String]
          #   Required. The name of the DlpJob resource.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::DlpJob]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::DlpJob]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.dlp_job_path("[PROJECT]", "[DLP_JOB]")
          #   response = dlp_client.get_dlp_job(formatted_name)

          def get_dlp_job \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::GetDlpJobRequest)
            @get_dlp_job.call(req, options, &block)
          end

          # Deletes a long-running DlpJob. This method indicates that the client is
          # no longer interested in the DlpJob result. The job will be cancelled if
          # possible.
          # See https://cloud.google.com/dlp/docs/inspecting-storage and
          # https://cloud.google.com/dlp/docs/compute-risk-analysis to learn more.
          #
          # @param name [String]
          #   Required. The name of the DlpJob resource to be deleted.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.dlp_job_path("[PROJECT]", "[DLP_JOB]")
          #   dlp_client.delete_dlp_job(formatted_name)

          def delete_dlp_job \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeleteDlpJobRequest)
            @delete_dlp_job.call(req, options, &block)
            nil
          end

          # Starts asynchronous cancellation on a long-running DlpJob. The server
          # makes a best effort to cancel the DlpJob, but success is not
          # guaranteed.
          # See https://cloud.google.com/dlp/docs/inspecting-storage and
          # https://cloud.google.com/dlp/docs/compute-risk-analysis to learn more.
          #
          # @param name [String]
          #   Required. The name of the DlpJob resource to be cancelled.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.dlp_job_path("[PROJECT]", "[DLP_JOB]")
          #   dlp_client.cancel_dlp_job(formatted_name)

          def cancel_dlp_job \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CancelDlpJobRequest)
            @cancel_dlp_job.call(req, options, &block)
            nil
          end

          # Finish a running hybrid DlpJob. Triggers the finalization steps and running
          # of any enabled actions that have not yet run.
          # Early access feature is in a pre-release state and might change or have
          # limited support. For more information, see
          # https://cloud.google.com/products#product-launch-stages.
          #
          # @param name [String]
          #   Required. The name of the DlpJob resource to be cancelled.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.dlp_job_path("[PROJECT]", "[DLP_JOB]")
          #   dlp_client.finish_dlp_job(formatted_name)

          def finish_dlp_job \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::FinishDlpJobRequest)
            @finish_dlp_job.call(req, options, &block)
            nil
          end

          # Inspect hybrid content and store findings to a job.
          # To review the findings inspect the job. Inspection will occur
          # asynchronously.
          # Early access feature is in a pre-release state and might change or have
          # limited support. For more information, see
          # https://cloud.google.com/products#product-launch-stages.
          #
          # @param name [String]
          #   Required. Resource name of the job to execute a hybrid inspect on, for
          #   example `projects/dlp-test-project/dlpJob/53234423`.
          # @param hybrid_item [Google::Privacy::Dlp::V2::HybridContentItem | Hash]
          #   The item to inspect.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::HybridContentItem`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::HybridInspectResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::HybridInspectResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #
          #   # TODO: Initialize `name`:
          #   name = ''
          #   response = dlp_client.hybrid_inspect_dlp_job(name)

          def hybrid_inspect_dlp_job \
              name,
              hybrid_item: nil,
              options: nil,
              &block
            req = {
              name: name,
              hybrid_item: hybrid_item
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::HybridInspectDlpJobRequest)
            @hybrid_inspect_dlp_job.call(req, options, &block)
          end

          # Lists job triggers.
          # See https://cloud.google.com/dlp/docs/creating-job-triggers to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example `projects/my-project-id`.
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param order_by [String]
          #   Comma separated list of triggeredJob fields to order by,
          #   followed by `asc` or `desc` postfix. This list is case-insensitive,
          #   default sorting order is ascending, redundant space characters are
          #   insignificant.
          #
          #   Example: `name asc,update_time, create_time desc`
          #
          #   Supported fields are:
          #
          #   * `create_time`: corresponds to time the JobTrigger was created.
          #   * `update_time`: corresponds to time the JobTrigger was last updated.
          #   * `last_run_time`: corresponds to the last time the JobTrigger ran.
          #   * `name`: corresponds to JobTrigger's name.
          #   * `display_name`: corresponds to JobTrigger's display name.
          #   * `status`: corresponds to JobTrigger's status.
          # @param filter [String]
          #   Allows filtering.
          #
          #   Supported syntax:
          #
          #   * Filter expressions are made up of one or more restrictions.
          #   * Restrictions can be combined by `AND` or `OR` logical operators. A
          #     sequence of restrictions implicitly uses `AND`.
          #   * A restriction has the form of `{field} {operator} {value}`.
          #   * Supported fields/values for inspect jobs:
          #     * `status` - HEALTHY|PAUSED|CANCELLED
          #       * `inspected_storage` - DATASTORE|CLOUD_STORAGE|BIGQUERY
          #       * 'last_run_time` - RFC 3339 formatted timestamp, surrounded by
          #         quotation marks. Nanoseconds are ignored.
          #       * 'error_count' - Number of errors that have occurred while running.
          #     * The operator must be `=` or `!=` for status and inspected_storage.
          #
          #     Examples:
          #
          #   * inspected_storage = cloud_storage AND status = HEALTHY
          #   * inspected_storage = cloud_storage OR inspected_storage = bigquery
          #   * inspected_storage = cloud_storage AND (state = PAUSED OR state = HEALTHY)
          #   * last_run_time > \"2017-12-12T00:00:00+00:00\"
          #
          #   The length of this field should be no more than 500 characters.
          # @param location_id [String]
          #   The geographic location where job triggers will be retrieved from.
          #   Use `-` for all locations. Reserved for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::JobTrigger>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::JobTrigger>]
          #   An enumerable of Google::Privacy::Dlp::V2::JobTrigger instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #
          #   # Iterate over all results.
          #   dlp_client.list_job_triggers(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   dlp_client.list_job_triggers(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_job_triggers \
              parent,
              page_size: nil,
              order_by: nil,
              filter: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              page_size: page_size,
              order_by: order_by,
              filter: filter,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListJobTriggersRequest)
            @list_job_triggers.call(req, options, &block)
          end

          # Gets a job trigger.
          # See https://cloud.google.com/dlp/docs/creating-job-triggers to learn more.
          #
          # @param name [String]
          #   Required. Resource name of the project and the triggeredJob, for example
          #   `projects/dlp-test-project/jobTriggers/53234423`.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::JobTrigger]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::JobTrigger]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.project_job_trigger_path("[PROJECT]", "[JOB_TRIGGER]")
          #   response = dlp_client.get_job_trigger(formatted_name)

          def get_job_trigger \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::GetJobTriggerRequest)
            @get_job_trigger.call(req, options, &block)
          end

          # Deletes a job trigger.
          # See https://cloud.google.com/dlp/docs/creating-job-triggers to learn more.
          #
          # @param name [String]
          #   Required. Resource name of the project and the triggeredJob, for example
          #   `projects/dlp-test-project/jobTriggers/53234423`.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #
          #   # TODO: Initialize `name`:
          #   name = ''
          #   dlp_client.delete_job_trigger(name)

          def delete_job_trigger \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeleteJobTriggerRequest)
            @delete_job_trigger.call(req, options, &block)
            nil
          end

          # Inspect hybrid content and store findings to a trigger. The inspection
          # will be processed asynchronously. To review the findings monitor the
          # jobs within the trigger.
          # Early access feature is in a pre-release state and might change or have
          # limited support. For more information, see
          # https://cloud.google.com/products#product-launch-stages.
          #
          # @param name [String]
          #   Required. Resource name of the trigger to execute a hybrid inspect on, for
          #   example `projects/dlp-test-project/jobTriggers/53234423`.
          # @param hybrid_item [Google::Privacy::Dlp::V2::HybridContentItem | Hash]
          #   The item to inspect.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::HybridContentItem`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::HybridInspectResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::HybridInspectResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #
          #   # TODO: Initialize `name`:
          #   name = ''
          #   response = dlp_client.hybrid_inspect_job_trigger(name)

          def hybrid_inspect_job_trigger \
              name,
              hybrid_item: nil,
              options: nil,
              &block
            req = {
              name: name,
              hybrid_item: hybrid_item
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::HybridInspectJobTriggerRequest)
            @hybrid_inspect_job_trigger.call(req, options, &block)
          end

          # Updates a job trigger.
          # See https://cloud.google.com/dlp/docs/creating-job-triggers to learn more.
          #
          # @param name [String]
          #   Required. Resource name of the project and the triggeredJob, for example
          #   `projects/dlp-test-project/jobTriggers/53234423`.
          # @param job_trigger [Google::Privacy::Dlp::V2::JobTrigger | Hash]
          #   New JobTrigger value.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::JobTrigger`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Mask to control which fields get updated.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::JobTrigger]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::JobTrigger]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.project_job_trigger_path("[PROJECT]", "[JOB_TRIGGER]")
          #   response = dlp_client.update_job_trigger(formatted_name)

          def update_job_trigger \
              name,
              job_trigger: nil,
              update_mask: nil,
              options: nil,
              &block
            req = {
              name: name,
              job_trigger: job_trigger,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::UpdateJobTriggerRequest)
            @update_job_trigger.call(req, options, &block)
          end

          # Creates a job trigger to run DLP actions such as scanning storage for
          # sensitive information on a set schedule.
          # See https://cloud.google.com/dlp/docs/creating-job-triggers to learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id.
          # @param job_trigger [Google::Privacy::Dlp::V2::JobTrigger | Hash]
          #   Required. The JobTrigger to create.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::JobTrigger`
          #   can also be provided.
          # @param trigger_id [String]
          #   The trigger id can contain uppercase and lowercase letters,
          #   numbers, and hyphens; that is, it must match the regular
          #   expression: `[a-zA-Z\\d-_]+`. The maximum length is 100
          #   characters. Can be empty to allow the system to generate one.
          # @param location_id [String]
          #   The geographic location to store the job trigger. Reserved for
          #   future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::JobTrigger]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::JobTrigger]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.project_path("[PROJECT]")
          #   response = dlp_client.create_job_trigger(formatted_parent)

          def create_job_trigger \
              parent,
              job_trigger: nil,
              trigger_id: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              job_trigger: job_trigger,
              trigger_id: trigger_id,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CreateJobTriggerRequest)
            @create_job_trigger.call(req, options, &block)
          end

          # Creates a pre-built stored infoType to be used for inspection.
          # See https://cloud.google.com/dlp/docs/creating-stored-infotypes to
          # learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param config [Google::Privacy::Dlp::V2::StoredInfoTypeConfig | Hash]
          #   Required. Configuration of the storedInfoType to create.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::StoredInfoTypeConfig`
          #   can also be provided.
          # @param stored_info_type_id [String]
          #   The storedInfoType ID can contain uppercase and lowercase letters,
          #   numbers, and hyphens; that is, it must match the regular
          #   expression: `[a-zA-Z\\d-_]+`. The maximum length is 100
          #   characters. Can be empty to allow the system to generate one.
          # @param location_id [String]
          #   The geographic location to store the stored infoType. Reserved for
          #   future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::StoredInfoType]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::StoredInfoType]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #   response = dlp_client.create_stored_info_type(formatted_parent)

          def create_stored_info_type \
              parent,
              config: nil,
              stored_info_type_id: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              config: config,
              stored_info_type_id: stored_info_type_id,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::CreateStoredInfoTypeRequest)
            @create_stored_info_type.call(req, options, &block)
          end

          # Updates the stored infoType by creating a new version. The existing version
          # will continue to be used until the new version is ready.
          # See https://cloud.google.com/dlp/docs/creating-stored-infotypes to
          # learn more.
          #
          # @param name [String]
          #   Required. Resource name of organization and storedInfoType to be updated,
          #   for example `organizations/433245324/storedInfoTypes/432452342` or
          #   projects/project-id/storedInfoTypes/432452342.
          # @param config [Google::Privacy::Dlp::V2::StoredInfoTypeConfig | Hash]
          #   Updated configuration for the storedInfoType. If not provided, a new
          #   version of the storedInfoType will be created with the existing
          #   configuration.
          #   A hash of the same form as `Google::Privacy::Dlp::V2::StoredInfoTypeConfig`
          #   can also be provided.
          # @param update_mask [Google::Protobuf::FieldMask | Hash]
          #   Mask to control which fields get updated.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::StoredInfoType]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::StoredInfoType]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_stored_info_type_path("[ORGANIZATION]", "[STORED_INFO_TYPE]")
          #   response = dlp_client.update_stored_info_type(formatted_name)

          def update_stored_info_type \
              name,
              config: nil,
              update_mask: nil,
              options: nil,
              &block
            req = {
              name: name,
              config: config,
              update_mask: update_mask
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::UpdateStoredInfoTypeRequest)
            @update_stored_info_type.call(req, options, &block)
          end

          # Gets a stored infoType.
          # See https://cloud.google.com/dlp/docs/creating-stored-infotypes to
          # learn more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and storedInfoType to be read,
          #   for example `organizations/433245324/storedInfoTypes/432452342` or
          #   projects/project-id/storedInfoTypes/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Privacy::Dlp::V2::StoredInfoType]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Privacy::Dlp::V2::StoredInfoType]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_stored_info_type_path("[ORGANIZATION]", "[STORED_INFO_TYPE]")
          #   response = dlp_client.get_stored_info_type(formatted_name)

          def get_stored_info_type \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::GetStoredInfoTypeRequest)
            @get_stored_info_type.call(req, options, &block)
          end

          # Lists stored infoTypes.
          # See https://cloud.google.com/dlp/docs/creating-stored-infotypes to
          # learn more.
          #
          # @param parent [String]
          #   Required. The parent resource name, for example projects/my-project-id or
          #   organizations/my-org-id.
          # @param page_size [Integer]
          #   The maximum number of resources contained in the underlying API
          #   response. If page streaming is performed per-resource, this
          #   parameter does not affect the return value. If page streaming is
          #   performed per-page, this determines the maximum number of
          #   resources in a page.
          # @param order_by [String]
          #   Comma separated list of fields to order by,
          #   followed by `asc` or `desc` postfix. This list is case-insensitive,
          #   default sorting order is ascending, redundant space characters are
          #   insignificant.
          #
          #   Example: `name asc, display_name, create_time desc`
          #
          #   Supported fields are:
          #
          #   * `create_time`: corresponds to time the most recent version of the
          #     resource was created.
          #   * `state`: corresponds to the state of the resource.
          #   * `name`: corresponds to resource name.
          #   * `display_name`: corresponds to info type's display name.
          # @param location_id [String]
          #   The geographic location where stored infoTypes will be retrieved from.
          #   Use `-` for all locations. Reserved for future extensions.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::StoredInfoType>]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Gax::PagedEnumerable<Google::Privacy::Dlp::V2::StoredInfoType>]
          #   An enumerable of Google::Privacy::Dlp::V2::StoredInfoType instances.
          #   See Google::Gax::PagedEnumerable documentation for other
          #   operations such as per-page iteration or access to the response
          #   object.
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_parent = Google::Cloud::Dlp::V2::DlpServiceClient.organization_path("[ORGANIZATION]")
          #
          #   # Iterate over all results.
          #   dlp_client.list_stored_info_types(formatted_parent).each do |element|
          #     # Process element.
          #   end
          #
          #   # Or iterate over results one page at a time.
          #   dlp_client.list_stored_info_types(formatted_parent).each_page do |page|
          #     # Process each page at a time.
          #     page.each do |element|
          #       # Process element.
          #     end
          #   end

          def list_stored_info_types \
              parent,
              page_size: nil,
              order_by: nil,
              location_id: nil,
              options: nil,
              &block
            req = {
              parent: parent,
              page_size: page_size,
              order_by: order_by,
              location_id: location_id
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::ListStoredInfoTypesRequest)
            @list_stored_info_types.call(req, options, &block)
          end

          # Deletes a stored infoType.
          # See https://cloud.google.com/dlp/docs/creating-stored-infotypes to
          # learn more.
          #
          # @param name [String]
          #   Required. Resource name of the organization and storedInfoType to be
          #   deleted, for example `organizations/433245324/storedInfoTypes/432452342` or
          #   projects/project-id/storedInfoTypes/432452342.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result []
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dlp"
          #
          #   dlp_client = Google::Cloud::Dlp.new(version: :v2)
          #   formatted_name = Google::Cloud::Dlp::V2::DlpServiceClient.organization_stored_info_type_path("[ORGANIZATION]", "[STORED_INFO_TYPE]")
          #   dlp_client.delete_stored_info_type(formatted_name)

          def delete_stored_info_type \
              name,
              options: nil,
              &block
            req = {
              name: name
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Privacy::Dlp::V2::DeleteStoredInfoTypeRequest)
            @delete_stored_info_type.call(req, options, &block)
            nil
          end
        end
      end
    end
  end
end
