# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/security_center/v1p1beta1/finding.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/cloud/security_center/v1p1beta1/security_marks_pb'
require 'google/protobuf/struct_pb'
require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.cloud.securitycenter.v1p1beta1.Finding" do
    optional :name, :string, 1
    optional :parent, :string, 2
    optional :resource_name, :string, 3
    optional :state, :enum, 4, "google.cloud.securitycenter.v1p1beta1.Finding.State"
    optional :category, :string, 5
    optional :external_uri, :string, 6
    map :source_properties, :string, :message, 7, "google.protobuf.Value"
    optional :security_marks, :message, 8, "google.cloud.securitycenter.v1p1beta1.SecurityMarks"
    optional :event_time, :message, 9, "google.protobuf.Timestamp"
    optional :create_time, :message, 10, "google.protobuf.Timestamp"
  end
  add_enum "google.cloud.securitycenter.v1p1beta1.Finding.State" do
    value :STATE_UNSPECIFIED, 0
    value :ACTIVE, 1
    value :INACTIVE, 2
  end
end

module Google::Cloud::SecurityCenter::V1p1beta1
  Finding = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.securitycenter.v1p1beta1.Finding").msgclass
  Finding::State = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.securitycenter.v1p1beta1.Finding.State").enummodule
end
