# Copyright 2017 Google LLC
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


require "google/cloud/firestore/v1"
require "google/cloud/firestore/field_path"
require "time"
require "stringio"

module Google
  module Cloud
    module Firestore
      ##
      # @private Helper module for converting Protobuf values.
      module Convert
        # rubocop:disable all
        module ClassMethods
          def time_to_timestamp time
            return nil if time.nil?

            # Force the object to be a Time object.
            time = time.to_time

            Google::Protobuf::Timestamp.new \
              seconds: time.to_i,
              nanos: time.nsec
          end

          def timestamp_to_time timestamp
            return nil if timestamp.nil?

            Time.at timestamp.seconds, Rational(timestamp.nanos, 1000)
          end

          def fields_to_hash fields, client
            Hash[fields.map do |key, value|
              [key.to_sym, value_to_raw(value, client)]
            end]
          end

          def hash_to_fields hash
            Hash[hash.map do |key, value|
              [String(key), raw_to_value(value)]
            end]
          end

          def value_to_raw value, client
            case value.value_type
            when :null_value
              nil
            when :boolean_value
              value.boolean_value
            when :integer_value
              Integer value.integer_value
            when :double_value
              value.double_value
            when :timestamp_value
              timestamp_to_time value.timestamp_value
            when :string_value
              value.string_value
            when :bytes_value
              StringIO.new value.bytes_value
            when :reference_value
              Google::Cloud::Firestore::DocumentReference.from_path \
                value.reference_value, client
            when :geo_point_value
              value.geo_point_value.to_h
            when :array_value
              value.array_value.values.map { |v| value_to_raw v, client }
            when :map_value
              fields_to_hash value.map_value.fields, client
            end
          end

          def raw_to_value obj
            if NilClass === obj
              Google::Firestore::V1::Value.new null_value: :NULL_VALUE
            elsif TrueClass === obj || FalseClass === obj
              Google::Firestore::V1::Value.new boolean_value: obj
            elsif Integer === obj
              Google::Firestore::V1::Value.new integer_value: obj
            elsif Numeric === obj # Any number not an integer is a double
              Google::Firestore::V1::Value.new double_value: obj.to_f
            elsif Time === obj || DateTime === obj || Date === obj
              Google::Firestore::V1::Value.new \
                timestamp_value: time_to_timestamp(obj.to_time)
            elsif String === obj || Symbol === obj
              Google::Firestore::V1::Value.new string_value: obj.to_s
            elsif Google::Cloud::Firestore::DocumentReference === obj
              Google::Firestore::V1::Value.new reference_value: obj.path
            elsif Array === obj
              values = obj.map { |o| raw_to_value(o) }
              Google::Firestore::V1::Value.new(array_value:
                Google::Firestore::V1::ArrayValue.new(values: values))
            elsif Hash === obj
              # keys have been changed to strings before the hash gets here
              geo_pairs = hash_is_geo_point? obj
              if geo_pairs
                Google::Firestore::V1::Value.new(
                  geo_point_value: hash_to_geo_point(obj, geo_pairs)
                )
              else
                fields = hash_to_fields obj
                Google::Firestore::V1::Value.new(map_value:
                  Google::Firestore::V1::MapValue.new(fields: fields))
              end
            elsif obj.respond_to?(:read) && obj.respond_to?(:rewind)
              obj.rewind
              content = obj.read.force_encoding "ASCII-8BIT"
              Google::Firestore::V1::Value.new bytes_value: content
            else
              raise ArgumentError,
                    "A value of type #{obj.class} is not supported."
            end
          end

          def hash_is_geo_point? hash
            return false unless hash.keys.count == 2

            pairs = hash.map { |k, v| [String(k), v] }.sort
            if pairs.map(&:first) == ["latitude".freeze, "longitude".freeze]
              pairs
            end
          end

          def hash_to_geo_point hash, pairs = nil
            pairs ||= hash_is_geo_point? hash

            raise ArgumentError, "value is not a geo point" unless pairs

            Google::Type::LatLng.new(
              latitude: pairs.first.last,
              longitude: pairs.last.last,
            )
          end

          def writes_for_create doc_path, data
            writes = []

            if is_field_value_nested data, :delete
              raise ArgumentError, "DELETE not allowed on create"
            end
            raise ArgumentError, "data is required" unless data.is_a? Hash

            data, field_paths_and_values = remove_field_value_from data

            if data.any? || field_paths_and_values.empty?
              write = Google::Firestore::V1::Write.new(
                update: Google::Firestore::V1::Document.new(
                  name: doc_path,
                  fields: hash_to_fields(data)),
                current_document: Google::Firestore::V1::Precondition.new(
                  exists: false)
              )
              writes << write
            end

            if field_paths_and_values.any?
              transform_write = transform_write doc_path, field_paths_and_values

              if data.empty?
                transform_write.current_document = \
                  Google::Firestore::V1::Precondition.new(exists: false)
              end

              writes << transform_write
            end

            writes
          end

          def writes_for_set doc_path, data, merge: nil
            raise ArgumentError, "data is required" unless data.is_a? Hash

            if merge
              if merge == true
                # extract the leaf node field paths from data
                field_paths = identify_leaf_nodes data
                allow_empty = true
              else
                field_paths = Array(merge).map do |field_path|
                  field_path = FieldPath.parse field_path unless field_path.is_a? FieldPath
                  field_path
                end
                allow_empty = false
              end
              return writes_for_set_merge doc_path, data, field_paths, allow_empty
            end

            writes = []

            data, delete_paths = remove_field_value_from data, :delete
            if delete_paths.any?
              raise ArgumentError, "DELETE not allowed on set"
            end

            data, field_paths_and_values = remove_field_value_from data

            writes << Google::Firestore::V1::Write.new(
              update: Google::Firestore::V1::Document.new(
                name: doc_path,
                fields: hash_to_fields(data))
            )

            if field_paths_and_values.any?
              writes << transform_write(doc_path, field_paths_and_values)
            end

            writes
          end

          def writes_for_set_merge doc_path, data, field_paths, allow_empty
            raise ArgumentError, "data is required" unless data.is_a? Hash

            validate_field_paths! field_paths

            writes = []

            # Ensure provided field paths are valid.
            all_valid = identify_leaf_nodes data
            all_valid_check = field_paths.map do |verify_path|
              if all_valid.include?(verify_path)
                true
              else
                found_in_all_valid = all_valid.select do |fp|
                  fp.formatted_string.start_with? "#{verify_path.formatted_string}."
                end
                found_in_all_valid.any?
              end
            end
            all_valid_check = all_valid_check.include? false
            raise ArgumentError, "all fields must be in data" if all_valid_check

            data, delete_field_paths_and_values = remove_field_value_from data, :delete
            data, field_paths_and_values = remove_field_value_from data

            delete_valid_check = delete_field_paths_and_values.keys.map do |delete_field_path|
              if field_paths.include? delete_field_path
                true
              else
                found_in_field_paths = field_paths.select do |fp|
                  fp.formatted_string.start_with? "#{delete_field_path.formatted_string}."
                end
                found_in_field_paths.any?
              end
            end
            delete_valid_check = delete_valid_check.include? false
            raise ArgumentError, "deleted field not included in merge" if delete_valid_check

            field_paths_and_values.select! do |server_time_path|
              field_paths.any? do |field_path|
                server_time_path.formatted_string.start_with? field_path.formatted_string
              end
            end

            # Choose only the data there are field paths for
            field_paths -= delete_field_paths_and_values.keys
            field_paths -= field_paths_and_values.keys
            data = select_by_field_paths data, field_paths
            # Restore delete paths
            field_paths += delete_field_paths_and_values.keys

            if data.empty? && !allow_empty
              if field_paths_and_values.empty? && delete_field_paths_and_values.empty?
                raise ArgumentError, "data required for set with merge"
              end
            end

            if data.any? || field_paths.any? || (allow_empty && field_paths_and_values.empty?)
              writes << Google::Firestore::V1::Write.new(
                update: Google::Firestore::V1::Document.new(
                  name: doc_path,
                  fields: hash_to_fields(data)),
                update_mask: Google::Firestore::V1::DocumentMask.new(
                  field_paths: field_paths.map(&:formatted_string).sort)
              )
            end

            if field_paths_and_values.any?
              writes << transform_write(doc_path, field_paths_and_values)
            end

            writes
          end

          def writes_for_update doc_path, data, update_time: nil
            writes = []

            raise ArgumentError, "data is required" unless data.is_a? Hash

            # Convert data to use FieldPath
            new_data_pairs = data.map do |key, value|
              key = FieldPath.parse key unless key.is_a? FieldPath
              [key, value]
            end

            # Duplicate field paths check
            validate_field_paths! new_data_pairs.map(&:first)

            delete_paths, new_data_pairs = new_data_pairs.partition do |field_path, value|
              value.is_a?(FieldValue) && value.type == :delete
            end

            root_field_paths_and_values, new_data_pairs = new_data_pairs.partition do |field_path, value|
              value.is_a? FieldValue
            end

            data = build_hash_from_field_paths_and_values new_data_pairs
            field_paths = new_data_pairs.map(&:first)

            delete_paths.map!(&:first)
            root_field_paths_and_values = Hash[root_field_paths_and_values]

            data, nested_deletes = remove_field_value_from data, :delete
            raise ArgumentError, "DELETE cannot be nested" if nested_deletes.any?

            data, nested_field_paths_and_values  = remove_field_value_from data

            field_paths_and_values = root_field_paths_and_values.merge nested_field_paths_and_values

            field_paths = (field_paths + delete_paths).uniq
            field_paths.each do |field_path|
              raise ArgumentError, "empty paths not allowed" if field_path.fields.empty?
            end

            if data.empty? && delete_paths.empty? && field_paths_and_values.empty?
              raise ArgumentError, "data is required"
            end

            if data.any? || delete_paths.any?
              write = Google::Firestore::V1::Write.new(
                update: Google::Firestore::V1::Document.new(
                  name: doc_path,
                  fields: hash_to_fields(data)),
                update_mask: Google::Firestore::V1::DocumentMask.new(
                  field_paths: (field_paths).map(&:formatted_string).sort),
                current_document: Google::Firestore::V1::Precondition.new(
                  exists: true)
              )
              if update_time
                write.current_document = \
                  Google::Firestore::V1::Precondition.new(
                    update_time: time_to_timestamp(update_time))
              end
              writes << write
            end

            if field_paths_and_values.any?
              transform_write = transform_write doc_path, field_paths_and_values
              if data.empty?
                transform_write.current_document = \
                  Google::Firestore::V1::Precondition.new(exists: true)
              end
              writes << transform_write
            end

            writes
          end

          def write_for_delete doc_path, exists: nil, update_time: nil
            if !exists.nil? && !update_time.nil?
              raise ArgumentError, "cannot specify both exists and update_time"
            end

            write = Google::Firestore::V1::Write.new(
              delete: doc_path
            )

            unless exists.nil? && update_time.nil?
              write.current_document = \
                Google::Firestore::V1::Precondition.new({
                  exists: exists, update_time: time_to_timestamp(update_time)
                }.delete_if { |_, v| v.nil? })
            end

            write
          end

          def is_field_value_nested obj, field_value_type = nil
            return obj if obj.is_a?(FieldValue) && (field_value_type.nil? || obj.type == field_value_type)

            if obj.is_a? Array
              obj.each { |o| val = is_field_value_nested o, field_value_type; return val if val }
            elsif obj.is_a? Hash
              obj.each { |_k, v| val = is_field_value_nested v, field_value_type; return val if val }
            end
            nil
          end

          def remove_field_value_from obj, field_value_type = nil
            return [nil, []] unless obj.is_a? Hash

            paths = []
            new_pairs = obj.map do |key, value|
              if value.is_a?(FieldValue) && (field_value_type.nil? || value.type == field_value_type)
                paths << [FieldPath.new(*key), value]
                nil # will be removed by calling compact
              else
                if value.is_a? Hash
                  unless value.empty?
                    nested_hash, nested_paths = remove_field_value_from value, field_value_type
                    if nested_paths.any?
                      nested_paths.each do |nested_field_path, nested_field_value|
                        updated_field_paths = ([key] + nested_field_path.fields).flatten
                        updated_field_path = FieldPath.new *updated_field_paths
                        paths << [updated_field_path, nested_field_value]
                      end
                    end
                    if nested_hash.empty?
                      nil # will be removed by calling compact
                    else
                      [String(key), nested_hash]
                    end
                  else
                    [String(key), value]
                  end
                else
                  if value.is_a? Array
                    nested_field_value = is_field_value_nested value, field_value_type
                    if nested_field_value
                      raise ArgumentError, "cannot nest #{nested_field_value.type} under arrays"
                    end
                  end

                  [String(key), value]
                end
              end
            end

            # return new data hash and field path/values hash
            [Hash[new_pairs.compact], Hash[paths]]
          end

          def identify_leaf_nodes hash
            paths = []

            hash.map do |key, value|
              if value.is_a? Hash
                nested_paths = identify_leaf_nodes value
                nested_paths.each do |nested_path|
                  paths << (([key] + nested_path.fields).flatten)
                end
              else
                paths << [key]
              end
            end

            paths.map { |path| FieldPath.new *path }
          end

          def identify_all_file_paths hash
            paths = []

            hash.map do |key, value|
              paths << [key]

              if value.is_a? Hash
                nested_paths = identify_all_file_paths value
                nested_paths.each do |nested_path|
                  paths << (([key] + nested_path.fields).flatten)
                end
              end
            end

            paths.map { |path| FieldPath.new *path }
          end

          def select_by_field_paths hash, field_paths
            new_hash = {}
            field_paths.map do |field_path|
              selected_hash = select_field_path hash, field_path
              deep_merge_hashes new_hash, selected_hash
            end
            new_hash
          end

          def select_field_path hash, field_path
            ret_hash = {}
            tmp_hash = ret_hash
            prev_hash = ret_hash
            dup_hash = hash.dup
            fields = field_path.fields.dup
            last_field = nil

            # squash fields until the key exists?
            if fields.count > 1
              until dup_hash.key? fields.first
                fields.unshift "#{fields.shift}.#{fields.shift}"
                break if fields.count <= 1
              end
            end

            fields.each do |field|
              prev_hash[last_field] = tmp_hash unless last_field.nil?
              last_field = field
              tmp_hash[field] = {}
              prev_hash = tmp_hash
              tmp_hash = tmp_hash[field]
              dup_hash = dup_hash[field]
            end
            prev_hash[last_field] = dup_hash
            prev_hash.delete_if { |_k, v| v.nil? }
            ret_hash
          end

          def validate_field_paths! field_paths
            field_paths_strings = field_paths.map(&:formatted_string)
            if field_paths_strings.size != field_paths_strings.uniq.size
              raise ArgumentError, "duplicate field paths"
            end
            field_paths_strings.each do |field_path|
              prefix_check = field_paths_strings.select do |this_path|
                this_path.start_with? "#{field_path}."
              end
              if prefix_check.any?
                raise ArgumentError, "one field cannot be a prefix of another"
              end
            end
          end

          def deep_merge_hashes left_hash, right_hash
            right_hash.each_pair do |key, right_value|
              left_value = left_hash[key]

              if left_value.is_a?(Hash) && right_value.is_a?(Hash)
                left_hash[key] = deep_merge_hashes left_value, right_value
              else
                left_hash[key] = right_value
              end
            end

            left_hash
          end

          START_FIELD_PATH_CHARS = /\A[a-zA-Z_]/
          INVALID_FIELD_PATH_CHARS = /[\~\*\/\[\]]/
          ESCAPED_FIELD_PATH = /\A\`(.*)\`\z/

          def build_hash_from_field_paths_and_values pairs
            pairs.each do |field_path, _value|
              raise ArgumentError unless field_path.is_a? FieldPath
            end

            dup_hash = {}

            pairs.each do |field_path, value|
              tmp_dup = dup_hash
              last_field = nil
              field_path.fields.map(&:to_sym).each do |field|
                raise ArgumentError, "empty paths not allowed" if field.empty?
                tmp_dup = tmp_dup[last_field] unless last_field.nil?
                last_field = field
                tmp_dup[field] ||= {}
              end
              tmp_dup[last_field] = value
            end

            dup_hash
          end

          def escape_field_path str
            str = String str

            return "`#{str}`" if INVALID_FIELD_PATH_CHARS.match str
            return "`#{str}`" if str["."] # contains "."
            return str if START_FIELD_PATH_CHARS.match str

            "`#{str}`"
          end

          def transform_write doc_path, paths
            field_transforms = paths.map do |field_path, field_value|
              to_field_transform field_path, field_value
            end

            Google::Firestore::V1::Write.new(
              transform: Google::Firestore::V1::DocumentTransform.new(
                document: doc_path,
                field_transforms: field_transforms
              )
            )
          end

          def to_field_transform field_path, field_value
            if field_value.type == :server_time
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                set_to_server_value: :REQUEST_TIME
              )
            elsif field_value.type == :array_union
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                append_missing_elements: raw_to_value(Array(field_value.value)).array_value
              )
            elsif field_value.type == :array_delete
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                remove_all_from_array: raw_to_value(Array(field_value.value)).array_value
              )
            elsif field_value.type == :increment
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                increment: raw_to_value(field_value.value)
              )
            elsif field_value.type == :maximum
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                maximum: raw_to_value(field_value.value)
              )
            elsif field_value.type == :minimum
              Google::Firestore::V1::DocumentTransform::FieldTransform.new(
                field_path: field_path.formatted_string,
                minimum: raw_to_value(field_value.value)
              )
            else
              raise ArgumentError, "unknown field transform #{field_value.type}"
            end
          end
        end
        # rubocop:enable all

        extend ClassMethods
      end
    end
  end
end
