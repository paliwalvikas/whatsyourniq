# Copyright 2016 Google LLC
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


require "google/cloud/spanner/errors"
require "google/cloud/spanner/credentials"
require "google/cloud/spanner/version"
require "google/cloud/spanner/v1"
require "google/cloud/spanner/admin/instance/v1"
require "google/cloud/spanner/admin/database/v1"
require "google/cloud/spanner/convert"
require "uri"

module Google
  module Cloud
    module Spanner
      ##
      # @private Represents the gRPC Spanner service, including all the API
      # methods.
      class Service
        attr_accessor :project, :credentials, :timeout, :client_config, :host,
                      :lib_name, :lib_version

        ##
        # Creates a new Service instance.
        def initialize project, credentials, host: nil, timeout: nil,
                       client_config: nil, lib_name: nil, lib_version: nil
          @project = project
          @credentials = credentials
          @host = host || V1::SpannerClient::SERVICE_ADDRESS
          @timeout = timeout
          @client_config = client_config || {}
          @lib_name = lib_name
          @lib_version = lib_version
        end

        def channel
          require "grpc"
          GRPC::Core::Channel.new host, chan_args, chan_creds
        end

        def chan_args
          { "grpc.service_config_disable_resolution" => 1 }
        end

        def chan_creds
          return credentials if insecure?
          require "grpc"
          GRPC::Core::ChannelCredentials.new.compose \
            GRPC::Core::CallCredentials.new credentials.client.updater_proc
        end

        def service
          return mocked_service if mocked_service
          @service ||= \
            V1::SpannerClient.new(
              credentials: channel,
              timeout: timeout,
              client_config: client_config,
              service_address: service_address,
              service_port: service_port,
              lib_name: lib_name_with_prefix,
              lib_version: Google::Cloud::Spanner::VERSION
            )
        end
        attr_accessor :mocked_service

        def instances
          return mocked_instances if mocked_instances
          @instances ||= \
            Admin::Instance::V1::InstanceAdminClient.new(
              credentials: channel,
              timeout: timeout,
              client_config: client_config,
              service_address: service_address,
              service_port: service_port,
              lib_name: lib_name_with_prefix,
              lib_version: Google::Cloud::Spanner::VERSION
            )
        end
        attr_accessor :mocked_instances

        def databases
          return mocked_databases if mocked_databases
          @databases ||= \
            Admin::Database::V1::DatabaseAdminClient.new(
              credentials: channel,
              timeout: timeout,
              client_config: client_config,
              service_address: service_address,
              service_port: service_port,
              lib_name: lib_name_with_prefix,
              lib_version: Google::Cloud::Spanner::VERSION
            )
        end
        attr_accessor :mocked_databases

        def insecure?
          credentials == :this_channel_is_insecure
        end

        def list_instances token: nil, max: nil
          call_options = nil
          call_options = Google::Gax::CallOptions.new page_token: token if token

          execute do
            paged_enum = instances.list_instances project_path,
                                                  page_size: max,
                                                  options: call_options

            paged_enum.page.response
          end
        end

        def get_instance name
          execute do
            instances.get_instance instance_path(name)
          end
        end

        def create_instance instance_id, name: nil, config: nil, nodes: nil,
                            labels: nil
          labels = Hash[labels.map { |k, v| [String(k), String(v)] }] if labels

          create_obj = Google::Spanner::Admin::Instance::V1::Instance.new({
            display_name: name, config: instance_config_path(config),
            node_count: nodes, labels: labels
          }.delete_if { |_, v| v.nil? })

          execute do
            instances.create_instance project_path, instance_id, create_obj
          end
        end

        def update_instance instance_obj
          mask = Google::Protobuf::FieldMask.new(
            paths: %w[display_name node_count labels]
          )

          execute do
            instances.update_instance instance_obj, mask
          end
        end

        def delete_instance name
          execute do
            instances.delete_instance instance_path(name)
          end
        end

        def get_instance_policy name
          execute do
            instances.get_iam_policy instance_path(name)
          end
        end

        def set_instance_policy name, new_policy
          execute do
            instances.set_iam_policy instance_path(name), new_policy
          end
        end

        def test_instance_permissions name, permissions
          execute do
            instances.test_iam_permissions instance_path(name), permissions
          end
        end

        def list_instance_configs token: nil, max: nil
          call_options = nil
          call_options = Google::Gax::CallOptions.new page_token: token if token

          execute do
            paged_enum = instances.list_instance_configs project_path,
                                                         page_size: max,
                                                         options: call_options

            paged_enum.page.response
          end
        end

        def get_instance_config name
          execute do
            instances.get_instance_config instance_config_path(name)
          end
        end

        def list_databases instance_id, token: nil, max: nil
          call_options = nil
          call_options = Google::Gax::CallOptions.new page_token: token if token

          execute do
            paged_enum = databases.list_databases instance_path(instance_id),
                                                  page_size: max,
                                                  options: call_options

            paged_enum.page.response
          end
        end

        def get_database instance_id, database_id
          execute do
            databases.get_database database_path(instance_id, database_id)
          end
        end

        def create_database instance_id, database_id, statements: []
          execute do
            databases.create_database \
              instance_path(instance_id),
              "CREATE DATABASE `#{database_id}`",
              extra_statements: Array(statements)
          end
        end

        def drop_database instance_id, database_id
          execute do
            databases.drop_database database_path(instance_id, database_id)
          end
        end

        def get_database_ddl instance_id, database_id
          execute do
            databases.get_database_ddl database_path(instance_id, database_id)
          end
        end

        def update_database_ddl instance_id, database_id, statements: [],
                                operation_id: nil
          execute do
            databases.update_database_ddl \
              database_path(instance_id, database_id),
              Array(statements),
              operation_id: operation_id
          end
        end

        def get_database_policy instance_id, database_id
          execute do
            databases.get_iam_policy database_path(instance_id, database_id)
          end
        end

        def set_database_policy instance_id, database_id, new_policy
          execute do
            databases.set_iam_policy \
              database_path(instance_id, database_id), new_policy
          end
        end

        def test_database_permissions instance_id, database_id, permissions
          execute do
            databases.test_iam_permissions \
              database_path(instance_id, database_id), permissions
          end
        end

        def get_session session_name
          opts = default_options_from_session session_name
          execute do
            service.get_session session_name, options: opts
          end
        end

        def create_session database_name, labels: nil
          opts = default_options_from_session database_name
          session = Google::Spanner::V1::Session.new labels: labels if labels
          execute do
            service.create_session database_name, session: session,
                                                  options: opts
          end
        end

        def batch_create_sessions database_name, session_count, labels: nil
          opts = default_options_from_session database_name
          session = Google::Spanner::V1::Session.new labels: labels if labels
          execute do
            # The response may have fewer sessions than requested in the RPC.
            service.batch_create_sessions database_name,
                                          session_count,
                                          session_template: session,
                                          options: opts
          end
        end

        def delete_session session_name
          opts = default_options_from_session session_name
          execute do
            service.delete_session session_name, options: opts
          end
        end

        def execute_streaming_sql session_name, sql, transaction: nil,
                                  params: nil, types: nil, resume_token: nil,
                                  partition_token: nil, seqno: nil,
                                  query_options: nil
          opts = default_options_from_session session_name
          execute do
            service.execute_streaming_sql \
              session_name, sql, transaction: transaction,
                                 params: params,
                                 param_types: types,
                                 resume_token: resume_token,
                                 partition_token: partition_token,
                                 seqno: seqno,
                                 query_options: query_options,
                                 options: opts
          end
        end

        def execute_batch_dml session_name, transaction, statements, seqno
          opts = default_options_from_session session_name
          statements = statements.map(&:to_grpc)
          results = execute do
            service.execute_batch_dml session_name,
                                      transaction,
                                      statements,
                                      seqno,
                                      options: opts
          end
          if results.status.code.zero?
            results.result_sets.map { |rs| rs.stats.row_count_exact }
          else
            begin
              raise Google::Cloud::Error.from_error results.status
            rescue Google::Cloud::Error
              raise Google::Cloud::Spanner::BatchUpdateError.from_grpc results
            end
          end
        end

        def streaming_read_table session_name, table_name, columns, keys: nil,
                                 index: nil, transaction: nil, limit: nil,
                                 resume_token: nil, partition_token: nil
          opts = default_options_from_session session_name
          execute do
            service.streaming_read \
              session_name, table_name, columns, keys,
              transaction: transaction, index: index, limit: limit,
              resume_token: resume_token, partition_token: partition_token,
              options: opts
          end
        end

        def partition_read session_name, table_name, columns, transaction,
                           keys: nil, index: nil, partition_size_bytes: nil,
                           max_partitions: nil
          partition_opts = partition_options partition_size_bytes,
                                             max_partitions

          opts = default_options_from_session session_name

          execute do
            service.partition_read \
              session_name, table_name, keys,
              transaction: transaction, index: index, columns: columns,
              partition_options: partition_opts, options: opts
          end
        end

        def partition_query session_name, sql, transaction, params: nil,
                            types: nil, partition_size_bytes: nil,
                            max_partitions: nil
          partition_opts = partition_options partition_size_bytes,
                                             max_partitions

          opts = default_options_from_session session_name

          execute do
            service.partition_query \
              session_name, sql,
              transaction: transaction,
              params: params, param_types: types,
              partition_options: partition_opts, options: opts
          end
        end

        def commit session_name, mutations = [], transaction_id: nil
          tx_opts = nil
          if transaction_id.nil?
            tx_opts = Google::Spanner::V1::TransactionOptions.new(
              read_write: Google::Spanner::V1::TransactionOptions::ReadWrite.new
            )
          end
          opts = default_options_from_session session_name
          execute do
            service.commit \
              session_name, mutations,
              transaction_id: transaction_id, single_use_transaction: tx_opts,
              options: opts
          end
        end

        def rollback session_name, transaction_id
          opts = default_options_from_session session_name
          execute do
            service.rollback session_name, transaction_id, options: opts
          end
        end

        def begin_transaction session_name
          tx_opts = Google::Spanner::V1::TransactionOptions.new(
            read_write: Google::Spanner::V1::TransactionOptions::ReadWrite.new
          )
          opts = default_options_from_session session_name
          execute do
            service.begin_transaction session_name, tx_opts, options: opts
          end
        end

        def create_snapshot session_name, strong: nil, timestamp: nil,
                            staleness: nil
          tx_opts = Google::Spanner::V1::TransactionOptions.new(
            read_only: Google::Spanner::V1::TransactionOptions::ReadOnly.new(
              {
                strong: strong,
                read_timestamp: Convert.time_to_timestamp(timestamp),
                exact_staleness: Convert.number_to_duration(staleness),
                return_read_timestamp: true
              }.delete_if { |_, v| v.nil? }
            )
          )
          opts = default_options_from_session session_name
          execute do
            service.begin_transaction session_name, tx_opts, options: opts
          end
        end

        def create_pdml session_name
          tx_opts = Google::Spanner::V1::TransactionOptions.new(
            partitioned_dml: \
              Google::Spanner::V1::TransactionOptions::PartitionedDml.new
          )
          opts = default_options_from_session session_name
          execute do
            service.begin_transaction session_name, tx_opts, options: opts
          end
        end

        def create_backup instance_id, database_id, backup_id, expire_time
          backup = {
            database: database_path(instance_id, database_id),
            expire_time: expire_time
          }
          execute do
            databases.create_backup \
              instance_path(instance_id),
              backup_id,
              backup
          end
        end

        def get_backup instance_id, backup_id
          execute do
            databases.get_backup backup_path(instance_id, backup_id)
          end
        end

        def update_backup backup, update_mask
          execute do
            databases.update_backup backup, update_mask
          end
        end

        def delete_backup instance_id, backup_id
          execute do
            databases.delete_backup backup_path(instance_id, backup_id)
          end
        end

        def list_backups instance_id, filter: nil, page_size: nil
          execute do
            databases.list_backups \
              instance_path(instance_id),
              filter,
              page_size: page_size
          end
        end

        def list_database_operations instance_id, filter: nil, page_size: nil
          execute do
            databases.list_database_operations \
              instance_path(instance_id),
              filter,
              page_size: page_size
          end
        end

        def list_backup_operations instance_id, filter: nil, page_size: nil
          execute do
            databases.list_backup_operations \
              instance_path(instance_id),
              filter,
              page_size: page_size
          end
        end

        def restore_database \
          backup_instance_id,
          backup_id,
          database_instance_id,
          database_id
          execute do
            databases.restore_database \
              instance_path(database_instance_id),
              database_id,
              backup: backup_path(backup_instance_id, backup_id)
          end
        end

        def inspect
          "#{self.class}(#{@project})"
        end

        protected

        def service_address
          return nil if host.nil?
          URI.parse("//#{host}").host
        end

        def service_port
          return nil if host.nil?
          URI.parse("//#{host}").port
        end

        def lib_name_with_prefix
          return "gccl" if [nil, "gccl"].include? lib_name

          value = lib_name.dup
          value << "/#{lib_version}" if lib_version
          value << " gccl"
        end

        def default_options_from_session session_name
          default_prefix = session_name.split("/sessions/").first
          Google::Gax::CallOptions.new kwargs: \
            { "google-cloud-resource-prefix" => default_prefix }
        end

        def partition_options partition_size_bytes, max_partitions
          return nil unless partition_size_bytes || max_partitions
          partition_opts = Google::Spanner::V1::PartitionOptions.new
          if partition_size_bytes
            partition_opts.partition_size_bytes = partition_size_bytes
          end
          partition_opts.max_partitions = max_partitions if max_partitions
          partition_opts
        end

        def project_path
          Admin::Instance::V1::InstanceAdminClient.project_path project
        end

        def instance_path name
          return name if name.to_s.include? "/"
          Admin::Instance::V1::InstanceAdminClient.instance_path(
            project, name
          )
        end

        def instance_config_path name
          return name if name.to_s.include? "/"
          Admin::Instance::V1::InstanceAdminClient.instance_config_path(
            project, name.to_s
          )
        end

        def database_path instance_id, database_id
          Admin::Database::V1::DatabaseAdminClient.database_path(
            project, instance_id, database_id
          )
        end

        def session_path instance_id, database_id, session_id
          V1::SpannerClient.session_path(
            project, instance_id, database_id, session_id
          )
        end

        def backup_path instance_id, backup_id
          Admin::Database::V1::DatabaseAdminClient.backup_path(
            project, instance_id, backup_id
          )
        end

        def execute
          yield
        rescue Google::Gax::GaxError => e
          # GaxError wraps BadStatus, but exposes it as #cause
          raise Google::Cloud::Error.from_error(e.cause)
        rescue GRPC::BadStatus => e
          raise Google::Cloud::Error.from_error(e)
        end
      end
    end
  end
end
