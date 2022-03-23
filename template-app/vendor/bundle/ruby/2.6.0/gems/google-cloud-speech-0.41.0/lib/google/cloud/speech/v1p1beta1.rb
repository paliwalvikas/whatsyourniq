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


require "google/cloud/speech/v1p1beta1/speech_client"
require "google/cloud/speech/v1p1beta1/helpers"
require "google/cloud/speech/v1p1beta1/cloud_speech_pb"

module Google
  module Cloud
    module Speech
      # rubocop:disable LineLength

      ##
      # # Ruby Client for Cloud Speech-to-Text API
      #
      # [Cloud Speech-to-Text API][Product Documentation]:
      # Converts audio to text by applying powerful neural network models.
      # - [Product Documentation][]
      #
      # ## Quick Start
      # In order to use this library, you first need to go through the following
      # steps:
      #
      # 1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
      # 2. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
      # 3. [Enable the Cloud Speech-to-Text API.](https://console.cloud.google.com/apis/library/speech.googleapis.com)
      # 4. [Setup Authentication.](https://googleapis.dev/ruby/google-cloud-speech/latest/file.AUTHENTICATION.html)
      #
      # ### Installation
      # ```
      # $ gem install google-cloud-speech
      # ```
      #
      # ### Preview
      # #### SpeechClient
      # ```rb
      # require "google/cloud/speech"
      #
      # speech_client = Google::Cloud::Speech.new(version: :v1p1beta1)
      # language_code = "en-US"
      # sample_rate_hertz = 44100
      # encoding = :FLAC
      # config = {
      #   language_code: language_code,
      #   sample_rate_hertz: sample_rate_hertz,
      #   encoding: encoding
      # }
      # uri = "gs://cloud-samples-data/speech/brooklyn_bridge.flac"
      # audio = { uri: uri }
      # response = speech_client.recognize(config, audio)
      # ```
      #
      # ### Next Steps
      # - Read the [Cloud Speech-to-Text API Product documentation][Product Documentation]
      #   to learn more about the product and see How-to Guides.
      # - View this [repository's main README](https://github.com/googleapis/google-cloud-ruby/blob/master/README.md)
      #   to see the full list of Cloud APIs that we cover.
      #
      # [Product Documentation]: https://cloud.google.com/speech
      #
      # ## Enabling Logging
      #
      # To enable logging for this library, set the logger for the underlying [gRPC](https://github.com/grpc/grpc/tree/master/src/ruby) library.
      # The logger that you set may be a Ruby stdlib [`Logger`](https://ruby-doc.org/stdlib-2.5.0/libdoc/logger/rdoc/Logger.html) as shown below,
      # or a [`Google::Cloud::Logging::Logger`](https://googleapis.dev/ruby/google-cloud-logging/latest)
      # that will write logs to [Stackdriver Logging](https://cloud.google.com/logging/). See [grpc/logconfig.rb](https://github.com/grpc/grpc/blob/master/src/ruby/lib/grpc/logconfig.rb)
      # and the gRPC [spec_helper.rb](https://github.com/grpc/grpc/blob/master/src/ruby/spec/spec_helper.rb) for additional information.
      #
      # Configuring a Ruby stdlib logger:
      #
      # ```ruby
      # require "logger"
      #
      # module MyLogger
      #   LOGGER = Logger.new $stderr, level: Logger::WARN
      #   def logger
      #     LOGGER
      #   end
      # end
      #
      # # Define a gRPC module-level logger method before grpc/logconfig.rb loads.
      # module GRPC
      #   extend MyLogger
      # end
      # ```
      #
      module V1p1beta1
        # rubocop:enable LineLength

        ##
        # Service that implements Google Cloud Speech API.
        #
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
        def self.new \
            credentials: nil,
            scopes: nil,
            client_config: nil,
            timeout: nil,
            metadata: nil,
            service_address: nil,
            service_port: nil,
            exception_transformer: nil,
            lib_name: nil,
            lib_version: nil
          kwargs = {
            credentials: credentials,
            scopes: scopes,
            client_config: client_config,
            timeout: timeout,
            metadata: metadata,
            exception_transformer: exception_transformer,
            lib_name: lib_name,
            service_address: service_address,
            service_port: service_port,
            lib_version: lib_version
          }.select { |_, v| v != nil }
          Google::Cloud::Speech::V1p1beta1::SpeechClient.new(**kwargs)
        end
      end
    end
  end
end
