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
# https://github.com/googleapis/googleapis/blob/master/google/cloud/texttospeech/v1/cloud_tts.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.


require "json"
require "pathname"

require "google/gax"

require "google/cloud/texttospeech/v1/cloud_tts_pb"
require "google/cloud/text_to_speech/v1/credentials"
require "google/cloud/text_to_speech/version"

module Google
  module Cloud
    module TextToSpeech
      module V1
        # Service that implements Google Cloud Text-to-Speech API.
        #
        # @!attribute [r] text_to_speech_stub
        #   @return [Google::Cloud::TextToSpeech::V1::TextToSpeech::Stub]
        class TextToSpeechClient
          # @private
          attr_reader :text_to_speech_stub

          # The default address of the service.
          SERVICE_ADDRESS = "texttospeech.googleapis.com".freeze

          # The default port of the service.
          DEFAULT_SERVICE_PORT = 443

          # The default set of gRPC interceptors.
          GRPC_INTERCEPTORS = []

          DEFAULT_TIMEOUT = 30

          # The scopes needed to make gRPC calls to all of the methods defined in
          # this service.
          ALL_SCOPES = [
            "https://www.googleapis.com/auth/cloud-platform"
          ].freeze


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
            require "google/cloud/texttospeech/v1/cloud_tts_services_pb"

            credentials ||= Google::Cloud::TextToSpeech::V1::Credentials.default

            if credentials.is_a?(String) || credentials.is_a?(Hash)
              updater_proc = Google::Cloud::TextToSpeech::V1::Credentials.new(credentials).updater_proc
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

            package_version = Google::Cloud::TextToSpeech::VERSION

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
              "text_to_speech_client_config.json"
            )
            defaults = client_config_file.open do |f|
              Google::Gax.construct_settings(
                "google.cloud.texttospeech.v1.TextToSpeech",
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
            @text_to_speech_stub = Google::Gax::Grpc.create_stub(
              service_path,
              port,
              chan_creds: chan_creds,
              channel: channel,
              updater_proc: updater_proc,
              scopes: scopes,
              interceptors: interceptors,
              &Google::Cloud::TextToSpeech::V1::TextToSpeech::Stub.method(:new)
            )

            @list_voices = Google::Gax.create_api_call(
              @text_to_speech_stub.method(:list_voices),
              defaults["list_voices"],
              exception_transformer: exception_transformer
            )
            @synthesize_speech = Google::Gax.create_api_call(
              @text_to_speech_stub.method(:synthesize_speech),
              defaults["synthesize_speech"],
              exception_transformer: exception_transformer
            )
          end

          # Service calls

          # Returns a list of Voice supported for synthesis.
          #
          # @param language_code [String]
          #   Optional. Recommended.
          #   [BCP-47](https://www.rfc-editor.org/rfc/bcp/bcp47.txt) language tag. If
          #   specified, the ListVoices call will only return voices that can be used to
          #   synthesize this language_code. E.g. when specifying "en-NZ", you will get
          #   supported "en-*" voices; when specifying "no", you will get supported
          #   "no-*" (Norwegian) and "nb-*" (Norwegian Bokmal) voices; specifying "zh"
          #   will also get supported "cmn-*" voices; specifying "zh-hk" will also get
          #   supported "yue-*" voices.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Cloud::TextToSpeech::V1::ListVoicesResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Cloud::TextToSpeech::V1::ListVoicesResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/text_to_speech"
          #
          #   text_to_speech_client = Google::Cloud::TextToSpeech.new(version: :v1)
          #   response = text_to_speech_client.list_voices

          def list_voices \
              language_code: nil,
              options: nil,
              &block
            req = {
              language_code: language_code
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::TextToSpeech::V1::ListVoicesRequest)
            @list_voices.call(req, options, &block)
          end

          # Synthesizes speech synchronously: receive results after all text input
          # has been processed.
          #
          # @param input [Google::Cloud::TextToSpeech::V1::SynthesisInput | Hash]
          #   Required. The Synthesizer requires either plain text or SSML as input.
          #   A hash of the same form as `Google::Cloud::TextToSpeech::V1::SynthesisInput`
          #   can also be provided.
          # @param voice [Google::Cloud::TextToSpeech::V1::VoiceSelectionParams | Hash]
          #   Required. The desired voice of the synthesized audio.
          #   A hash of the same form as `Google::Cloud::TextToSpeech::V1::VoiceSelectionParams`
          #   can also be provided.
          # @param audio_config [Google::Cloud::TextToSpeech::V1::AudioConfig | Hash]
          #   Required. The configuration of the synthesized audio.
          #   A hash of the same form as `Google::Cloud::TextToSpeech::V1::AudioConfig`
          #   can also be provided.
          # @param options [Google::Gax::CallOptions]
          #   Overrides the default settings for this call, e.g, timeout,
          #   retries, etc.
          # @yield [result, operation] Access the result along with the RPC operation
          # @yieldparam result [Google::Cloud::TextToSpeech::V1::SynthesizeSpeechResponse]
          # @yieldparam operation [GRPC::ActiveCall::Operation]
          # @return [Google::Cloud::TextToSpeech::V1::SynthesizeSpeechResponse]
          # @raise [Google::Gax::GaxError] if the RPC is aborted.
          # @example
          #   require "google/cloud/text_to_speech"
          #
          #   text_to_speech_client = Google::Cloud::TextToSpeech.new(version: :v1)
          #
          #   # TODO: Initialize `input`:
          #   input = {}
          #
          #   # TODO: Initialize `voice`:
          #   voice = {}
          #
          #   # TODO: Initialize `audio_config`:
          #   audio_config = {}
          #   response = text_to_speech_client.synthesize_speech(input, voice, audio_config)

          def synthesize_speech \
              input,
              voice,
              audio_config,
              options: nil,
              &block
            req = {
              input: input,
              voice: voice,
              audio_config: audio_config
            }.delete_if { |_, v| v.nil? }
            req = Google::Gax::to_proto(req, Google::Cloud::TextToSpeech::V1::SynthesizeSpeechRequest)
            @synthesize_speech.call(req, options, &block)
          end
        end
      end
    end
  end
end
