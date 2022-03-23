# Ruby Client for Cloud Speech-to-Text API

[Cloud Speech-to-Text API][Product Documentation]:
Converts audio to text by applying powerful neural network models.
- [Client Library Documentation][]
- [Product Documentation][]

## Quick Start
In order to use this library, you first need to go through the following
steps:

1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
2. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
3. [Enable the Cloud Speech-to-Text API.](https://console.cloud.google.com/apis/library/speech.googleapis.com)
4. [Setup Authentication.](https://googleapis.dev/ruby/google-cloud-speech/latest/file.AUTHENTICATION.html)

### Installation
```
$ gem install google-cloud-speech
```

### Migration Guide

The 0.30.0 release introduced breaking changes relative to the previous release,
0.29.0. For more details and instructions to migrate your code, please visit the
[migration
guide](https://cloud.google.com/speech-to-text/docs/ruby-client-migration).

### Preview
#### SpeechClient
```rb
require "google/cloud/speech"

speech_client = Google::Cloud::Speech.new
language_code = "en-US"
sample_rate_hertz = 44100
encoding = :FLAC
config = {
  language_code: language_code,
  sample_rate_hertz: sample_rate_hertz,
  encoding: encoding
}
uri = "gs://cloud-samples-data/speech/brooklyn_bridge.flac"
audio = { uri: uri }
response = speech_client.recognize(config, audio)
```

### Next Steps
- Read the [Client Library Documentation][] for Cloud Speech-to-Text API
  to see other available methods on the client.
- Read the [Cloud Speech-to-Text API Product documentation][Product Documentation]
  to learn more about the product and see How-to Guides.
- View this [repository's main README](https://github.com/googleapis/google-cloud-ruby/blob/master/README.md)
  to see the full list of Cloud APIs that we cover.

[Client Library Documentation]: https://googleapis.dev/ruby/google-cloud-speech/latest
[Product Documentation]: https://cloud.google.com/speech

## Enabling Logging

To enable logging for this library, set the logger for the underlying [gRPC](https://github.com/grpc/grpc/tree/master/src/ruby) library.
The logger that you set may be a Ruby stdlib [`Logger`](https://ruby-doc.org/stdlib-2.5.0/libdoc/logger/rdoc/Logger.html) as shown below,
or a [`Google::Cloud::Logging::Logger`](https://googleapis.dev/ruby/google-cloud-logging/latest)
that will write logs to [Stackdriver Logging](https://cloud.google.com/logging/). See [grpc/logconfig.rb](https://github.com/grpc/grpc/blob/master/src/ruby/lib/grpc/logconfig.rb)
and the gRPC [spec_helper.rb](https://github.com/grpc/grpc/blob/master/src/ruby/spec/spec_helper.rb) for additional information.

Configuring a Ruby stdlib logger:

```ruby
require "logger"

module MyLogger
  LOGGER = Logger.new $stderr, level: Logger::WARN
  def logger
    LOGGER
  end
end

# Define a gRPC module-level logger method before grpc/logconfig.rb loads.
module GRPC
  extend MyLogger
end
```

## Supported Ruby Versions

This library is supported on Ruby 2.4+.

Google provides official support for Ruby versions that are actively supported
by Ruby Core—that is, Ruby versions that are either in normal maintenance or
in security maintenance, and not end of life. Currently, this means Ruby 2.4
and later. Older versions of Ruby _may_ still work, but are unsupported and not
recommended. See https://www.ruby-lang.org/en/downloads/branches/ for details
about the Ruby support schedule.
