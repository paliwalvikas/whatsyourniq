require 'aws-sdk-s3'

ENV['S3_BUCKET'] ||= ''

aws_credentials = Aws::Credentials.new(
  ENV['S3_ACCESS_KEY_ID'],
  ENV['S3_SECRET_ACCESS_KEY']
)

S3_BUCKET = Aws::S3::Resource.new(
  region: 'us-east-1',
  credentials: aws_credentials,
  use_accelerate_endpoint: true
).bucket(ENV['S3_BUCKET'])
