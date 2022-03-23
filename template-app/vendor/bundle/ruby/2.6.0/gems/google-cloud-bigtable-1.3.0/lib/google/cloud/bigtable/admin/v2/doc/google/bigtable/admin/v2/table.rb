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
  module Bigtable
    module Admin
      module V2
        # Information about a table restore.
        # @!attribute [rw] source_type
        #   @return [Google::Bigtable::Admin::V2::RestoreSourceType]
        #     The type of the restore source.
        # @!attribute [rw] backup_info
        #   @return [Google::Bigtable::Admin::V2::BackupInfo]
        #     Information about the backup used to restore the table. The backup
        #     may no longer exist.
        class RestoreInfo; end

        # A collection of user data indexed by row, column, and timestamp.
        # Each table is served using the resources of its parent cluster.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. The unique name of the table. Values are of the form
        #     `projects/<project>/instances/<instance>/tables/[_a-zA-Z0-9][-_.a-zA-Z0-9]*`.
        #     Views: `NAME_ONLY`, `SCHEMA_VIEW`, `REPLICATION_VIEW`, `FULL`
        # @!attribute [rw] cluster_states
        #   @return [Hash{String => Google::Bigtable::Admin::V2::Table::ClusterState}]
        #     Output only. Map from cluster ID to per-cluster table state.
        #     If it could not be determined whether or not the table has data in a
        #     particular cluster (for example, if its zone is unavailable), then
        #     there will be an entry for the cluster with UNKNOWN `replication_status`.
        #     Views: `REPLICATION_VIEW`, `FULL`
        # @!attribute [rw] column_families
        #   @return [Hash{String => Google::Bigtable::Admin::V2::ColumnFamily}]
        #     (`CreationOnly`)
        #     The column families configured for this table, mapped by column family ID.
        #     Views: `SCHEMA_VIEW`, `FULL`
        # @!attribute [rw] granularity
        #   @return [Google::Bigtable::Admin::V2::Table::TimestampGranularity]
        #     (`CreationOnly`)
        #     The granularity (i.e. `MILLIS`) at which timestamps are stored in
        #     this table. Timestamps not matching the granularity will be rejected.
        #     If unspecified at creation time, the value will be set to `MILLIS`.
        #     Views: `SCHEMA_VIEW`, `FULL`.
        # @!attribute [rw] restore_info
        #   @return [Google::Bigtable::Admin::V2::RestoreInfo]
        #     Output only. If this table was restored from another data source (e.g. a
        #     backup), this field will be populated with information about the restore.
        class Table
          # The state of a table's data in a particular cluster.
          # @!attribute [rw] replication_state
          #   @return [Google::Bigtable::Admin::V2::Table::ClusterState::ReplicationState]
          #     Output only. The state of replication for the table in this cluster.
          class ClusterState
            # Table replication states.
            module ReplicationState
              # The replication state of the table is unknown in this cluster.
              STATE_NOT_KNOWN = 0

              # The cluster was recently created, and the table must finish copying
              # over pre-existing data from other clusters before it can begin
              # receiving live replication updates and serving Data API requests.
              INITIALIZING = 1

              # The table is temporarily unable to serve Data API requests from this
              # cluster due to planned internal maintenance.
              PLANNED_MAINTENANCE = 2

              # The table is temporarily unable to serve Data API requests from this
              # cluster due to unplanned or emergency maintenance.
              UNPLANNED_MAINTENANCE = 3

              # The table can serve Data API requests from this cluster. Depending on
              # replication delay, reads may not immediately reflect the state of the
              # table in other clusters.
              READY = 4

              # The table is fully created and ready for use after a restore, and is
              # being optimized for performance. When optimizations are complete, the
              # table will transition to `READY` state.
              READY_OPTIMIZING = 5
            end
          end

          # Possible timestamp granularities to use when keeping multiple versions
          # of data in a table.
          module TimestampGranularity
            # The user did not specify a granularity. Should not be returned.
            # When specified during table creation, MILLIS will be used.
            TIMESTAMP_GRANULARITY_UNSPECIFIED = 0

            # The table keeps data versioned at a granularity of 1ms.
            MILLIS = 1
          end

          # Defines a view over a table's fields.
          module View
            # Uses the default view for each method as documented in its request.
            VIEW_UNSPECIFIED = 0

            # Only populates `name`.
            NAME_ONLY = 1

            # Only populates `name` and fields related to the table's schema.
            SCHEMA_VIEW = 2

            # Only populates `name` and fields related to the table's replication
            # state.
            REPLICATION_VIEW = 3

            # Populates all fields.
            FULL = 4
          end
        end

        # A set of columns within a table which share a common configuration.
        # @!attribute [rw] gc_rule
        #   @return [Google::Bigtable::Admin::V2::GcRule]
        #     Garbage collection rule specified as a protobuf.
        #     Must serialize to at most 500 bytes.
        #
        #     NOTE: Garbage collection executes opportunistically in the background, and
        #     so it's possible for reads to return a cell even if it matches the active
        #     GC expression for its family.
        class ColumnFamily; end

        # Rule for determining which cells to delete during garbage collection.
        # @!attribute [rw] max_num_versions
        #   @return [Integer]
        #     Delete all cells in a column except the most recent N.
        # @!attribute [rw] max_age
        #   @return [Google::Protobuf::Duration]
        #     Delete cells in a column older than the given age.
        #     Values must be at least one millisecond, and will be truncated to
        #     microsecond granularity.
        # @!attribute [rw] intersection
        #   @return [Google::Bigtable::Admin::V2::GcRule::Intersection]
        #     Delete cells that would be deleted by every nested rule.
        # @!attribute [rw] union
        #   @return [Google::Bigtable::Admin::V2::GcRule::Union]
        #     Delete cells that would be deleted by any nested rule.
        class GcRule
          # A GcRule which deletes cells matching all of the given rules.
          # @!attribute [rw] rules
          #   @return [Array<Google::Bigtable::Admin::V2::GcRule>]
          #     Only delete cells which would be deleted by every element of `rules`.
          class Intersection; end

          # A GcRule which deletes cells matching any of the given rules.
          # @!attribute [rw] rules
          #   @return [Array<Google::Bigtable::Admin::V2::GcRule>]
          #     Delete cells which would be deleted by any element of `rules`.
          class Union; end
        end

        # A snapshot of a table at a particular time. A snapshot can be used as a
        # checkpoint for data restoration or a data source for a new table.
        #
        # Note: This is a private alpha release of Cloud Bigtable snapshots. This
        # feature is not currently available to most Cloud Bigtable customers. This
        # feature might be changed in backward-incompatible ways and is not recommended
        # for production use. It is not subject to any SLA or deprecation policy.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. The unique name of the snapshot.
        #     Values are of the form
        #     `projects/<project>/instances/<instance>/clusters/<cluster>/snapshots/<snapshot>`.
        # @!attribute [rw] source_table
        #   @return [Google::Bigtable::Admin::V2::Table]
        #     Output only. The source table at the time the snapshot was taken.
        # @!attribute [rw] data_size_bytes
        #   @return [Integer]
        #     Output only. The size of the data in the source table at the time the
        #     snapshot was taken. In some cases, this value may be computed
        #     asynchronously via a background process and a placeholder of 0 will be used
        #     in the meantime.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time when the snapshot is created.
        # @!attribute [rw] delete_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time when the snapshot will be deleted. The maximum amount
        #     of time a snapshot can stay active is 365 days. If 'ttl' is not specified,
        #     the default maximum of 365 days will be used.
        # @!attribute [rw] state
        #   @return [Google::Bigtable::Admin::V2::Snapshot::State]
        #     Output only. The current state of the snapshot.
        # @!attribute [rw] description
        #   @return [String]
        #     Output only. Description of the snapshot.
        class Snapshot
          # Possible states of a snapshot.
          module State
            # The state of the snapshot could not be determined.
            STATE_NOT_KNOWN = 0

            # The snapshot has been successfully created and can serve all requests.
            READY = 1

            # The snapshot is currently being created, and may be destroyed if the
            # creation process encounters an error. A snapshot may not be restored to a
            # table while it is being created.
            CREATING = 2
          end
        end

        # A backup of a Cloud Bigtable table.
        # @!attribute [rw] name
        #   @return [String]
        #     Output only. A globally unique identifier for the backup which cannot be
        #     changed. Values are of the form
        #     `projects/{project}/instances/{instance}/clusters/{cluster}/
        #        backups/[_a-zA-Z0-9][-_.a-zA-Z0-9]*`
        #     The final segment of the name must be between 1 and 50 characters
        #     in length.
        #
        #     The backup is stored in the cluster identified by the prefix of the backup
        #     name of the form
        #     `projects/{project}/instances/{instance}/clusters/{cluster}`.
        # @!attribute [rw] source_table
        #   @return [String]
        #     Required. Immutable. Name of the table from which this backup was created.
        #     This needs to be in the same instance as the backup. Values are of the form
        #     `projects/{project}/instances/{instance}/tables/{source_table}`.
        # @!attribute [rw] expire_time
        #   @return [Google::Protobuf::Timestamp]
        #     Required. The expiration time of the backup, with microseconds
        #     granularity that must be at least 6 hours and at most 30 days
        #     from the time the request is received. Once the `expire_time`
        #     has passed, Cloud Bigtable will delete the backup and free the
        #     resources used by the backup.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. `start_time` is the time that the backup was started
        #     (i.e. approximately the time the
        #     {Google::Bigtable::Admin::V2::BigtableTableAdmin::CreateBackup CreateBackup}
        #     request is received).  The row data in this backup will be no older than
        #     this timestamp.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. `end_time` is the time that the backup was finished. The row
        #     data in the backup will be no newer than this timestamp.
        # @!attribute [rw] size_bytes
        #   @return [Integer]
        #     Output only. Size of the backup in bytes.
        # @!attribute [rw] state
        #   @return [Google::Bigtable::Admin::V2::Backup::State]
        #     Output only. The current state of the backup.
        class Backup
          # Indicates the current state of the backup.
          module State
            # Not specified.
            STATE_UNSPECIFIED = 0

            # The pending backup is still being created. Operations on the
            # backup may fail with `FAILED_PRECONDITION` in this state.
            CREATING = 1

            # The backup is complete and ready for use.
            READY = 2
          end
        end

        # Information about a backup.
        # @!attribute [rw] backup
        #   @return [String]
        #     Output only. Name of the backup.
        # @!attribute [rw] start_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time that the backup was started. Row data in the backup
        #     will be no older than this timestamp.
        # @!attribute [rw] end_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. This time that the backup was finished. Row data in the
        #     backup will be no newer than this timestamp.
        # @!attribute [rw] source_table
        #   @return [String]
        #     Output only. Name of the table the backup was created from.
        class BackupInfo; end

        # Indicates the type of the restore source.
        module RestoreSourceType
          # No restore associated.
          RESTORE_SOURCE_TYPE_UNSPECIFIED = 0

          # A backup was used as the source of the restore.
          BACKUP = 1
        end
      end
    end
  end
end