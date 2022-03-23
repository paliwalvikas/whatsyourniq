# Ruby Client for Cloud Video Intelligence API

[Cloud Video Intelligence API][Product Documentation]:
Detects objects, explicit content, and scene changes in videos. It also
specifies the region for annotation and transcribes speech to text.
Supports both asynchronous API and streaming API.
- [Client Library Documentation][]
- [Product Documentation][]

## Quick Start
In order to use this library, you first need to go through the following
steps:

1. [Select or create a Cloud Platform project.](https://console.cloud.google.com/project)
2. [Enable billing for your project.](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
3. [Enable the Cloud Video Intelligence API.](https://console.cloud.google.com/apis/library/videointelligence.googleapis.com)
4. [Setup Authentication.](https://googleapis.dev/ruby/google-cloud-video_intelligence/latest/file.AUTHENTICATION.html)

### Installation
```
$ gem install google-cloud-video_intelligence
```

### Preview
#### VideoIntelligenceServiceClient
```rb
require "google/cloud/video_intelligence"

video_intelligence_client = Google::Cloud::VideoIntelligence.new
input_uri = "gs://cloud-samples-data/video/cat.mp4"
features_element = :LABEL_DETECTION
features = [features_element]

# Register a callback during the method call.
operation = video_intelligence_client.annotate_video(features, input_uri: input_uri) do |op|
  raise op.results.message if op.error?
  op_results = op.results
  # Process the results.

  metadata = op.metadata
  # Process the metadata.
end

# Or use the return value to register a callback.
operation.on_done do |op|
  raise op.results.message if op.error?
  op_results = op.results
  # Process the results.

  metadata = op.metadata
  # Process the metadata.
end

# Manually reload the operation.
operation.reload!

# Or block until the operation completes, triggering callbacks on
# completion.
operation.wait_until_done!
```

### Next Steps
- Read the [Client Library Documentation][] for Cloud Video Intelligence API
  to see other available methods on the client.
- Read the [Cloud Video Intelligence API Product documentation][Product Documentation]
  to learn more about the product and see How-to Guides.
- View this [repository's main README](https://github.com/googleapis/google-cloud-ruby/blob/master/README.md)
  to see the full list of Cloud APIs that we cover.

[Client Library Documentation]: https://googleapis.dev/ruby/google-cloud-video_intelligence/latest
[Product Documentation]: https://cloud.google.com/video-intelligence

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
