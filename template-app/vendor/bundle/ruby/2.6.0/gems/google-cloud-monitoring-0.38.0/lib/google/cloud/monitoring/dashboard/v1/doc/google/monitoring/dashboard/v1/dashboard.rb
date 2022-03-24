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
  module Monitoring
    module Dashboard
      module V1
        # A Google Stackdriver dashboard. Dashboards define the content and layout
        # of pages in the Stackdriver web application.
        # @!attribute [rw] name
        #   @return [String]
        #     The resource name of the dashboard.
        # @!attribute [rw] display_name
        #   @return [String]
        #     The mutable, human-readable name.
        # @!attribute [rw] etag
        #   @return [String]
        #     `etag` is used for optimistic concurrency control as a way to help
        #     prevent simultaneous updates of a policy from overwriting each other.
        #     An `etag` is returned in the response to `GetDashboard`, and
        #     users are expected to put that etag in the request to `UpdateDashboard` to
        #     ensure that their change will be applied to the same version of the
        #     Dashboard configuration. The field should not be passed during
        #     dashboard creation.
        # @!attribute [rw] grid_layout
        #   @return [Google::Monitoring::Dashboard::V1::GridLayout]
        #     Content is arranged with a basic layout that re-flows a simple list of
        #     informational elements like widgets or tiles.
        # @!attribute [rw] row_layout
        #   @return [Google::Monitoring::Dashboard::V1::RowLayout]
        #     The content is divided into equally spaced rows and the widgets are
        #     arranged horizontally.
        # @!attribute [rw] column_layout
        #   @return [Google::Monitoring::Dashboard::V1::ColumnLayout]
        #     The content is divided into equally spaced columns and the widgets are
        #     arranged vertically.
        class Dashboard; end
      end
    end
  end
end