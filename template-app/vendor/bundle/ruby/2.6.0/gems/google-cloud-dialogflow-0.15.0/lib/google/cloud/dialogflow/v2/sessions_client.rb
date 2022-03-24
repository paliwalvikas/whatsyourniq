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
# https://github.com/googleapis/googleapis/blob/master/google/cloud/dialogflow/v2/session.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"

require "google/cloud/dialogflow/v2/session_pb"
require "google/cloud/dialogflow/v2/credentials"
require "google/cloud/dialogflow/version"

module Google
  module Cloud
    module Dialogflow
      module V2
        # A session represents an interaction with a user. You retrieve user input
        # and pass it to the {Google::Cloud::Dialogflow::V2::Sessions::DetectIntent DetectIntent} (or
        # {Google::Cloud::Dialogflow::V2::Sessions::StreamingDetectIntent StreamingDetectIntent}) method to determine
        # user intent and respond.
        #
        # @!attribute [r] sessions_stub
        #   @return [Google::Cloud::Dialogflow::V2::Sessions::Stub]
        class SessionsClient
          # @private
          attr_reader :sessions_stub

          # The default address of the service.
          SERVICE_ADDRESS = "dialogflow.googleapis.com".freeze

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 443

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          DEFAULT_TIMEOUT = 30

          # The scopes needed to make gRPC calls to all of the methods defined in
          # this service.
          ALL_SCOPES = [
            "https://www.googleapis.com/auth/cloud-platform",
            "https://www.googleapis.com/auth/dialogflow"
          ].freeze


          SESSION_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
            "projects/{project}/agent/sessions/{session}"
          )

          private_constant :SESSION_PATH_TEMPLATE

          # Returns a fully-qualified session resource name string.
          # @param project [String]
          # @param session [String]
          # @return [String]
          def self.session_path project, session
            SESSION_PATH_TEMPLATE.render(
              :"project" => project,
              :"session" => session
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
            require "google/cloud/dialogflow/v2/session_services_pb"

            credentials ||= Google::Cloud::Dialogflow::V2::Credentials.default

            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::Dialogflow::V2::Credentials.new(credentials).updater_proc
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

            package_version = Google::Cloud::Dialogflow::VERSION

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
              "sessions_client_config.json"
            )
            defaults = client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.cloud.dialogflow.v2.Sessions",
                JSON.parse(f.read),
                client_config,
                Google::Gax::Grpc::STATUS_CODE_NAMES,
                timeout,
                errors: Google::Gax::Grpc::API_ERRORS,
                metadata: headers
              )
            end

            # Allow overriding the service path/port in subclasses.
            service_path = service_address || self.class::SERVICE_ADDRESS
            port = service_port || self.class::DEFAULT_SERVICE_PORT
            interceptors = self.class::GRPC_INTERCEPTORS
            @sessions_stub = Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds: chan_creds,
              channel: channel,
              updater_proc: updater_proc,
              scopes: scopes,
              interceptors: interceptors,
              &Google::Cloud::Dialogflow::V2::Sessions::Stub.method(:new)
            )

            @detect_intent = Google::Gax.create_api_call(
              @sessions_stub.method(:detect_intent),
              defaults["detect_intent"],
              exception_transformer: exception_transformer,
              params_extractor: proc do |request|
                {'session' => request.session}
              end
            )
            @streaming_detect_intent = Google::Gax.create_api_call(
              @sessions_stub.method(:streaming_detect_intent),
              defaults["streaming_detect_intent"],
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          # Processes a natural language query and returns structured, actionable data
          # as a result. This method is not idempotent, because it may cause contexts
          # and session entity types to be updated, which in turn might affect
          # results of future queries.
          #
          # @param session [String]
          #   Required. The name of the session this query is sent to. Format:
          #   `projects/<Project ID>/agent/sessions/<Session ID>`. It's up to the API
          #   caller to choose an appropriate session ID. It can be a random number or
          #   some type of user identifier (preferably hashed). The length of the session
          #   ID must not exceed 36 bytes.
          # @param query_input [Google::Cloud::Dialogflow::V2::QueryInput | Hash]
          #   Required. The input specification. It can be set to:
          #
          #   1.  an audio config
          #       which instructs the speech recognizer how to process the speech audio,
          #
          #   2.  a conversational query in the form of text, or
          #
          #   3.  an event that specifies which intent to trigger.
          #   A hash of the same form as `Google::Cloud::Dialogflow::V2::QueryInput`
          #   can also be provided.
          # @param query_params [Google::Cloud::Dialogflow::V2::QueryParameters | Hash]
          #   The parameters of this query.
          #   A hash of the same form as `Google::Cloud::Dialogflow::V2::QueryParameters`
          #   can also be provided.
          # @param output_audio_config [Google::Cloud::Dialogflow::V2::OutputAudioConfig | Hash]
          #   Instructs the speech synthesizer how to generate the output
          #   audio. If this field is not set and agent-level speech synthesizer is not
          #   configured, no output audio is generated.
          #   A hash of the same form as `Google::Cloud::Dialogflow::V2::OutputAudioConfig`
          #   can also be provided.
          # @param output_audio_config_mask [Google::Protobuf::FieldMask | Hash]
          #   Mask for {Google::Cloud::Dialogflow::V2::DetectIntentRequest#output_audio_config output_audio_config} indicating which settings in this
          #   request-level config should override speech synthesizer settings defined at
          #   agent-level.
          #
          #   If unspecified or empty, {Google::Cloud::Dialogflow::V2::DetectIntentRequest#output_audio_config output_audio_config} replaces the agent-level
          #   config in its entirety.
          #   A hash of the same form as `Google::Protobuf::FieldMask`
          #   can also be provided.
          # @param input_audio [String]
          #   The natural language speech audio to be processed. This field
          #   should be populated iff `query_input` is set to an input audio config.
          #   A single request can contain up to 1 minute of speech audio data.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Cloud::Dialogflow::V2::DetectIntentResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Cloud::Dialogflow::V2::DetectIntentResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/dialogflow"
          #
          #   sessions_client = Google::Cloud::Dialogflow::Sessions.new(version: :v2)
          #   formatted_session = Google::Cloud::Dialogflow::V2::SessionsClient.session_path("[PROJECT]", "[SESSION]")
          #
          #   # TODO: Initialize `query_input`:
          #   query_input = {}
          #   response = sessions_client.detect_intent(formatted_session, query_input)

          def detect_intent \
              session,
              query_input,
              query_params: nil,
              output_audio_config: nil,
              output_audio_config_mask: nil,
              input_audio: nil,
              options: nil,
              &block
            req = {
              session: session,
              query_input: query_input,
              query_params: query_params,
              output_audio_config: output_audio_config,
              output_audio_config_mask: output_audio_config_mask,
              input_audio: input_audio
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::Dialogflow::V2::DetectIntentRequest)
            @detect_intent.call(req, options, &block)
          end

          # Processes a natural language query in audio format in a streaming fashion
          # and returns structured, actionable data as a result. This method is only
          # available via the gRPC API (not REST).
          #
          # @param reqs [Enumerable<Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest>]
          #   The input requests.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @return [Enumerable<Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse>]
          #   An enumerable of Google::Cloud::Dialogflow::V2::StreamingDetectIntentResponse instances.
          #
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          #
          # @note
          #   EXPERIMENTAL:
          #     Streaming requests are still undergoing review.
          #     This method interface might change in the future.
          #
          # @example
          #   require "google/cloud/dialogflow"
          #
          #   sessions_client = Google::Cloud::Dialogflow::Sessions.new(version: :v2)
          #
          #   # TODO: Initialize `session`:
          #   session = ''
          #
          #   # TODO: Initialize `query_input`:
          #   query_input = {}
          #   request = { session: session, query_input: query_input }
          #   requests = [request]
          #   sessions_client.streaming_detect_intent(requests).each do |element|
          #     # Process element.
          #   end

          def streaming_detect_intent reqs, options: nil
            request_protos = reqs.lazy.map do |req|
              Google::Gax::to_proto(req, Google::Cloud::Dialogflow::V2::StreamingDetectIntentRequest)
            end
            @streaming_detect_intent.call(request_protos, options)
          end
        end
      end
    end
  end
end
