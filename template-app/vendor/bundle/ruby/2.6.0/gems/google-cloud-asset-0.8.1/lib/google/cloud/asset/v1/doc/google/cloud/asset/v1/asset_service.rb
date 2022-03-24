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


module Google
  module Cloud
    module Asset
      module V1
        # Export asset request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The relative name of the root asset. This can only be an
        #     organization number (such as "organizations/123"), a project ID (such as
        #     "projects/my-project-id"), or a project number (such as "projects/12345"),
        #     or a folder number (such as "folders/123").
        # @!attribute [rw] read_time
        #   @return [Google::Protobuf::Timestamp]
        #     Timestamp to take an asset snapshot. This can only be set to a timestamp
        #     between 2018-10-02 UTC (inclusive) and the current time. If not specified,
        #     the current time will be used. Due to delays in resource data collection
        #     and indexing, there is a volatile window during which running the same
        #     query may get different results.
        # @!attribute [rw] asset_types
        #   @return [Array<String>]
        #     A list of asset types of which to take a snapshot for. For example:
        #     "compute.googleapis.com/Disk". If specified, only matching assets will be
        #     returned. See [Introduction to Cloud Asset
        #     Inventory](https://cloud.google.com/resource-manager-inventory/docs/overview)
        #     for all supported asset types.
        # @!attribute [rw] content_type
        #   @return [Google::Cloud::Asset::V1::ContentType]
        #     Asset content type. If not specified, no content but the asset name will be
        #     returned.
        # @!attribute [rw] output_config
        #   @return [Google::Cloud::Asset::V1::OutputConfig]
        #     Required. Output configuration indicating where the results will be output
        #     to. All results will be in newline delimited JSON format.
        class ExportAssetsRequest; end

        # The export asset response. This message is returned by the
        # {Google::Longrunning::Operations::GetOperation} method in the returned
        # {Google::Longrunning::Operation#response} field.
        # @!attribute [rw] read_time
        #   @return [Google::Protobuf::Timestamp]
        #     Time the snapshot was taken.
        # @!attribute [rw] output_config
        #   @return [Google::Cloud::Asset::V1::OutputConfig]
        #     Output configuration indicating where the results were output to.
        #     All results are in JSON format.
        class ExportAssetsResponse; end

        # Batch get assets history request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The relative name of the root asset. It can only be an
        #     organization number (such as "organizations/123"), a project ID (such as
        #     "projects/my-project-id")", or a project number (such as "projects/12345").
        # @!attribute [rw] asset_names
        #   @return [Array<String>]
        #     A list of the full names of the assets. For example:
        #     `//compute.googleapis.com/projects/my_project_123/zones/zone1/instances/instance1`.
        #     See [Resource
        #     Names](https://cloud.google.com/apis/design/resource_names#full_resource_name)
        #     and [Resource Name
        #     Format](https://cloud.google.com/resource-manager-inventory/docs/resource-name-format)
        #     for more info.
        #
        #     The request becomes a no-op if the asset name list is empty, and the max
        #     size of the asset name list is 100 in one request.
        # @!attribute [rw] content_type
        #   @return [Google::Cloud::Asset::V1::ContentType]
        #     Optional. The content type.
        # @!attribute [rw] read_time_window
        #   @return [Google::Cloud::Asset::V1::TimeWindow]
        #     Optional. The time window for the asset history. Both start_time and
        #     end_time are optional and if set, it must be after 2018-10-02 UTC. If
        #     end_time is not set, it is default to current timestamp. If start_time is
        #     not set, the snapshot of the assets at end_time will be returned. The
        #     returned results contain all temporal assets whose time window overlap with
        #     read_time_window.
        class BatchGetAssetsHistoryRequest; end

        # Batch get assets history response.
        # @!attribute [rw] assets
        #   @return [Array<Google::Cloud::Asset::V1::TemporalAsset>]
        #     A list of assets with valid time windows.
        class BatchGetAssetsHistoryResponse; end

        # Create asset feed request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The name of the project/folder/organization where this feed
        #     should be created in. It can only be an organization number (such as
        #     "organizations/123"), a folder number (such as "folders/123"), a project ID
        #     (such as "projects/my-project-id")", or a project number (such as
        #     "projects/12345").
        # @!attribute [rw] feed_id
        #   @return [String]
        #     Required. This is the client-assigned asset feed identifier and it needs to
        #     be unique under a specific parent project/folder/organization.
        # @!attribute [rw] feed
        #   @return [Google::Cloud::Asset::V1::Feed]
        #     Required. The feed details. The field `name` must be empty and it will be generated
        #     in the format of:
        #     projects/project_number/feeds/feed_id
        #     folders/folder_number/feeds/feed_id
        #     organizations/organization_number/feeds/feed_id
        class CreateFeedRequest; end

        # Get asset feed request.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The name of the Feed and it must be in the format of:
        #     projects/project_number/feeds/feed_id
        #     folders/folder_number/feeds/feed_id
        #     organizations/organization_number/feeds/feed_id
        class GetFeedRequest; end

        # List asset feeds request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The parent project/folder/organization whose feeds are to be
        #     listed. It can only be using project/folder/organization number (such as
        #     "folders/12345")", or a project ID (such as "projects/my-project-id").
        class ListFeedsRequest; end

        # @!attribute [rw] feeds
        #   @return [Array<Google::Cloud::Asset::V1::Feed>]
        #     A list of feeds.
        class ListFeedsResponse; end

        # Update asset feed request.
        # @!attribute [rw] feed
        #   @return [Google::Cloud::Asset::V1::Feed]
        #     Required. The new values of feed details. It must match an existing feed and the
        #     field `name` must be in the format of:
        #     projects/project_number/feeds/feed_id or
        #     folders/folder_number/feeds/feed_id or
        #     organizations/organization_number/feeds/feed_id.
        # @!attribute [rw] update_mask
        #   @return [Google::Protobuf::FieldMask]
        #     Required. Only updates the `feed` fields indicated by this mask.
        #     The field mask must not be empty, and it must not contain fields that
        #     are immutable or only set by the server.
        class UpdateFeedRequest; end

        # @!attribute [rw] name
        #   @return [String]
        #     Required. The name of the feed and it must be in the format of:
        #     projects/project_number/feeds/feed_id
        #     folders/folder_number/feeds/feed_id
        #     organizations/organization_number/feeds/feed_id
        class DeleteFeedRequest; end

        # Output configuration for export assets destination.
        # @!attribute [rw] gcs_destination
        #   @return [Google::Cloud::Asset::V1::GcsDestination]
        #     Destination on Cloud Storage.
        # @!attribute [rw] bigquery_destination
        #   @return [Google::Cloud::Asset::V1::BigQueryDestination]
        #     Destination on BigQuery. The output table stores the fields in asset
        #     proto as columns in BigQuery. The resource/iam_policy field is converted
        #     to a record with each field to a column, except metadata to a single JSON
        #     string.
        class OutputConfig; end

        # A Cloud Storage location.
        # @!attribute [rw] uri
        #   @return [String]
        #     The uri of the Cloud Storage object. It's the same uri that is used by
        #     gsutil. For example: "gs://bucket_name/object_name". See [Viewing and
        #     Editing Object
        #     Metadata](https://cloud.google.com/storage/docs/viewing-editing-metadata)
        #     for more information.
        # @!attribute [rw] uri_prefix
        #   @return [String]
        #     The uri prefix of all generated Cloud Storage objects. For example:
        #     "gs://bucket_name/object_name_prefix". Each object uri is in format:
        #     "gs://bucket_name/object_name_prefix/<asset type>/<shard number> and only
        #     contains assets for that type. <shard number> starts from 0. For example:
        #     "gs://bucket_name/object_name_prefix/compute.googleapis.com/Disk/0" is
        #     the first shard of output objects containing all
        #     compute.googleapis.com/Disk assets. An INVALID_ARGUMENT error will be
        #     returned if file with the same name "gs://bucket_name/object_name_prefix"
        #     already exists.
        class GcsDestination; end

        # A BigQuery destination.
        # @!attribute [rw] dataset
        #   @return [String]
        #     Required. The BigQuery dataset in format
        #     "projects/projectId/datasets/datasetId", to which the snapshot result
        #     should be exported. If this dataset does not exist, the export call returns
        #     an error.
        # @!attribute [rw] table
        #   @return [String]
        #     Required. The BigQuery table to which the snapshot result should be
        #     written. If this table does not exist, a new table with the given name
        #     will be created.
        # @!attribute [rw] force
        #   @return [true, false]
        #     If the destination table already exists and this flag is `TRUE`, the
        #     table will be overwritten by the contents of assets snapshot. If the flag
        #     is not set and the destination table already exists, the export call
        #     returns an error.
        class BigQueryDestination; end

        # A Cloud Pubsub destination.
        # @!attribute [rw] topic
        #   @return [String]
        #     The name of the Cloud Pub/Sub topic to publish to.
        #     For example: `projects/PROJECT_ID/topics/TOPIC_ID`.
        class PubsubDestination; end

        # Output configuration for asset feed destination.
        # @!attribute [rw] pubsub_destination
        #   @return [Google::Cloud::Asset::V1::PubsubDestination]
        #     Destination on Cloud Pubsub.
        class FeedOutputConfig; end

        # An asset feed used to export asset updates to a destinations.
        # An asset feed filter controls what updates are exported.
        # The asset feed must be created within a project, organization, or
        # folder. Supported destinations are:
        # Cloud Pub/Sub topics.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The format will be
        #     projects/\\{project_number}/feeds/{client-assigned_feed_identifier} or
        #     folders/\\{folder_number}/feeds/{client-assigned_feed_identifier} or
        #     organizations/\\{organization_number}/feeds/{client-assigned_feed_identifier}
        #
        #     The client-assigned feed identifier must be unique within the parent
        #     project/folder/organization.
        # @!attribute [rw] asset_names
        #   @return [Array<String>]
        #     A list of the full names of the assets to receive updates. You must specify
        #     either or both of asset_names and asset_types. Only asset updates matching
        #     specified asset_names and asset_types are exported to the feed. For
        #     example:
        #     `//compute.googleapis.com/projects/my_project_123/zones/zone1/instances/instance1`.
        #     See [Resource
        #     Names](https://cloud.google.com/apis/design/resource_names#full_resource_name)
        #     for more info.
        # @!attribute [rw] asset_types
        #   @return [Array<String>]
        #     A list of types of the assets to receive updates. You must specify either
        #     or both of asset_names and asset_types. Only asset updates matching
        #     specified asset_names and asset_types are exported to the feed.
        #     For example:
        #     "compute.googleapis.com/Disk" See [Introduction to Cloud Asset
        #     Inventory](https://cloud.google.com/resource-manager/docs/cloud-asset-inventory/overview)
        #     for all supported asset types.
        # @!attribute [rw] content_type
        #   @return [Google::Cloud::Asset::V1::ContentType]
        #     Asset content type. If not specified, no content but the asset name and
        #     type will be returned.
        # @!attribute [rw] feed_output_config
        #   @return [Google::Cloud::Asset::V1::FeedOutputConfig]
        #     Required. Feed output configuration defining where the asset updates are
        #     published to.
        class Feed; end

        # Asset content type.
        module ContentType
          # Unspecified content type.
          CONTENT_TYPE_UNSPECIFIED = 0

          # Resource metadata.
          RESOURCE = 1

          # The actual IAM policy set on a resource.
          IAM_POLICY = 2

          # The Cloud Organization Policy set on an asset.
          ORG_POLICY = 4

          # The Cloud Access context mananger Policy set on an asset.
          ACCESS_POLICY = 5
        end
      end
    end
  end
end