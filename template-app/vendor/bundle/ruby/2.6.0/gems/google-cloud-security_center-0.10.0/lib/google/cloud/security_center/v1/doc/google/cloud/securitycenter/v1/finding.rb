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
    module Securitycenter
      module V1
        # Cloud Security Command Center (Cloud SCC) finding.
        #
        # A finding is a record of assessment data like security, risk, health, or
        # privacy, that is ingested into Cloud SCC for presentation, notification,
        # analysis, policy testing, and enforcement. For example, a
        # cross-site scripting (XSS) vulnerability in an App Engine application is a
        # finding.
        # @!attribute [rw] name
        #   @return [String]
        #     The relative resource name of this finding. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     Example:
        #     "organizations/{organization_id}/sources/{source_id}/findings/{finding_id}"
        # @!attribute [rw] parent
        #   @return [String]
        #     The relative resource name of the source the finding belongs to. See:
        #     https://cloud.google.com/apis/design/resource_names#relative_resource_name
        #     This field is immutable after creation time.
        #     For example:
        #     "organizations/{organization_id}/sources/{source_id}"
        # @!attribute [rw] resource_name
        #   @return [String]
        #     For findings on Google Cloud Platform (GCP) resources, the full resource
        #     name of the GCP resource this finding is for. See:
        #     https://cloud.google.com/apis/design/resource_names#full_resource_name
        #     When the finding is for a non-GCP resource, the resourceName can be a
        #     customer or partner defined string.
        #     This field is immutable after creation time.
        # @!attribute [rw] state
        #   @return [Google::Cloud::SecurityCenter::V1::Finding::State]
        #     The state of the finding.
        # @!attribute [rw] category
        #   @return [String]
        #     The additional taxonomy group within findings from a given source.
        #     This field is immutable after creation time.
        #     Example: "XSS_FLASH_INJECTION"
        # @!attribute [rw] external_uri
        #   @return [String]
        #     The URI that, if available, points to a web page outside of Cloud SCC
        #     where additional information about the finding can be found. This field is
        #     guaranteed to be either empty or a well formed URL.
        # @!attribute [rw] source_properties
        #   @return [Hash{String => Google::Protobuf::Value}]
        #     Source specific properties. These properties are managed by the source
        #     that writes the finding. The key names in the source_properties map must be
        #     between 1 and 255 characters, and must start with a letter and contain
        #     alphanumeric characters or underscores only.
        # @!attribute [rw] security_marks
        #   @return [Google::Cloud::SecurityCenter::V1::SecurityMarks]
        #     Output only. User specified security marks. These marks are entirely
        #     managed by the user and come from the SecurityMarks resource that belongs
        #     to the finding.
        # @!attribute [rw] event_time
        #   @return [Google::Protobuf::Timestamp]
        #     The time at which the event took place. For example, if the finding
        #     represents an open firewall it would capture the time the detector believes
        #     the firewall became open. The accuracy is determined by the detector.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     The time at which the finding was created in Cloud SCC.
        class Finding
          # The state of the finding.
          module State
            # Unspecified state.
            STATE_UNSPECIFIED = 0

            # The finding requires attention and has not been addressed yet.
            ACTIVE = 1

            # The finding has been fixed, triaged as a non-issue or otherwise addressed
            # and is no longer active.
            INACTIVE = 2
          end
        end
      end
    end
  end
end