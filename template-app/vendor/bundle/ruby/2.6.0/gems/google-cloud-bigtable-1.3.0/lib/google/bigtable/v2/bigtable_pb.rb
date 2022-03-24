# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/bigtable/v2/bigtable.proto


require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
require 'google/api/resource_pb'
require 'google/bigtable/v2/data_pb'
require 'google/protobuf/wrappers_pb'
require 'google/rpc/status_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "google.bigtable.v2.ReadRowsRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 5
    optional :rows, :message, 2, "google.bigtable.v2.RowSet"
    optional :filter, :message, 3, "google.bigtable.v2.RowFilter"
    optional :rows_limit, :int64, 4
  end
  add_message "google.bigtable.v2.ReadRowsResponse" do
    repeated :chunks, :message, 1, "google.bigtable.v2.ReadRowsResponse.CellChunk"
    optional :last_scanned_row_key, :bytes, 2
  end
  add_message "google.bigtable.v2.ReadRowsResponse.CellChunk" do
    optional :row_key, :bytes, 1
    optional :family_name, :message, 2, "google.protobuf.StringValue"
    optional :qualifier, :message, 3, "google.protobuf.BytesValue"
    optional :timestamp_micros, :int64, 4
    repeated :labels, :string, 5
    optional :value, :bytes, 6
    optional :value_size, :int32, 7
    oneof :row_status do
      optional :reset_row, :bool, 8
      optional :commit_row, :bool, 9
    end
  end
  add_message "google.bigtable.v2.SampleRowKeysRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 2
  end
  add_message "google.bigtable.v2.SampleRowKeysResponse" do
    optional :row_key, :bytes, 1
    optional :offset_bytes, :int64, 2
  end
  add_message "google.bigtable.v2.MutateRowRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 4
    optional :row_key, :bytes, 2
    repeated :mutations, :message, 3, "google.bigtable.v2.Mutation"
  end
  add_message "google.bigtable.v2.MutateRowResponse" do
  end
  add_message "google.bigtable.v2.MutateRowsRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 3
    repeated :entries, :message, 2, "google.bigtable.v2.MutateRowsRequest.Entry"
  end
  add_message "google.bigtable.v2.MutateRowsRequest.Entry" do
    optional :row_key, :bytes, 1
    repeated :mutations, :message, 2, "google.bigtable.v2.Mutation"
  end
  add_message "google.bigtable.v2.MutateRowsResponse" do
    repeated :entries, :message, 1, "google.bigtable.v2.MutateRowsResponse.Entry"
  end
  add_message "google.bigtable.v2.MutateRowsResponse.Entry" do
    optional :index, :int64, 1
    optional :status, :message, 2, "google.rpc.Status"
  end
  add_message "google.bigtable.v2.CheckAndMutateRowRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 7
    optional :row_key, :bytes, 2
    optional :predicate_filter, :message, 6, "google.bigtable.v2.RowFilter"
    repeated :true_mutations, :message, 4, "google.bigtable.v2.Mutation"
    repeated :false_mutations, :message, 5, "google.bigtable.v2.Mutation"
  end
  add_message "google.bigtable.v2.CheckAndMutateRowResponse" do
    optional :predicate_matched, :bool, 1
  end
  add_message "google.bigtable.v2.ReadModifyWriteRowRequest" do
    optional :table_name, :string, 1
    optional :app_profile_id, :string, 4
    optional :row_key, :bytes, 2
    repeated :rules, :message, 3, "google.bigtable.v2.ReadModifyWriteRule"
  end
  add_message "google.bigtable.v2.ReadModifyWriteRowResponse" do
    optional :row, :message, 1, "google.bigtable.v2.Row"
  end
end

module Google
  module Bigtable
  end
end
module Google::Bigtable::V2
  ReadRowsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.ReadRowsRequest").msgclass
  ReadRowsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.ReadRowsResponse").msgclass
  ReadRowsResponse::CellChunk = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.ReadRowsResponse.CellChunk").msgclass
  SampleRowKeysRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.SampleRowKeysRequest").msgclass
  SampleRowKeysResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.SampleRowKeysResponse").msgclass
  MutateRowRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowRequest").msgclass
  MutateRowResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowResponse").msgclass
  MutateRowsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowsRequest").msgclass
  MutateRowsRequest::Entry = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowsRequest.Entry").msgclass
  MutateRowsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowsResponse").msgclass
  MutateRowsResponse::Entry = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.MutateRowsResponse.Entry").msgclass
  CheckAndMutateRowRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.CheckAndMutateRowRequest").msgclass
  CheckAndMutateRowResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.CheckAndMutateRowResponse").msgclass
  ReadModifyWriteRowRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.ReadModifyWriteRowRequest").msgclass
  ReadModifyWriteRowResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("google.bigtable.v2.ReadModifyWriteRowResponse").msgclass
end
