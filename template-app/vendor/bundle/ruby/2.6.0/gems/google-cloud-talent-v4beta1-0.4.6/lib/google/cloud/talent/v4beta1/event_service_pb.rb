# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/talent/v4beta1/event_service.proto

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/talent/v4beta1/event_pb'
require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/talent/v4beta1/event_service.proto", :syntax => :proto3) do
    add_message "google.cloud.talent.v4beta1.CreateClientEventRequest" do
      optional :parent, :string, 1
      optional :client_event, :message, 2, "google.cloud.talent.v4beta1.ClientEvent"
    end
  end
end

module Google
  module Cloud
    module Talent
      module V4beta1
        CreateClientEventRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.talent.v4beta1.CreateClientEventRequest").msgclass
      end
    end
  end
end