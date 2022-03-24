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
        # The `CreateDashboard` request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The project on which to execute the request. The format is
        #     `"projects/{project_id_or_number}"`. The \\{project_id_or_number} must match
        #     the dashboard resource name.
        # @!attribute [rw] dashboard
        #   @return [Google::Monitoring::Dashboard::V1::Dashboard]
        #     Required. The initial dashboard specification.
        class CreateDashboardRequest; end

        # The `ListDashboards` request.
        # @!attribute [rw] parent
        #   @return [String]
        #     Required. The scope of the dashboards to list. A project scope must be
        #     specified in the form of `"projects/{project_id_or_number}"`.
        # @!attribute [rw] page_size
        #   @return [Integer]
        #     A positive number that is the maximum number of results to return.
        #     If unspecified, a default of 1000 is used.
        # @!attribute [rw] page_token
        #   @return [String]
        #     If this field is not empty then it must contain the `nextPageToken` value
        #     returned by a previous call to this method.  Using this field causes the
        #     method to return additional results from the previous method call.
        class ListDashboardsRequest; end

        # The `ListDashboards` request.
        # @!attribute [rw] dashboards
        #   @return [Array<Google::Monitoring::Dashboard::V1::Dashboard>]
        #     The list of requested dashboards.
        # @!attribute [rw] next_page_token
        #   @return [String]
        #     If there are more results than have been returned, then this field is set
        #     to a non-empty value.  To see the additional results,
        #     use that value as `pageToken` in the next call to this method.
        class ListDashboardsResponse; end

        # The `GetDashboard` request.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the Dashboard. The format is one of
        #     `"dashboards/{dashboard_id}"` (for system dashboards) or
        #     `"projects/{project_id_or_number}/dashboards/{dashboard_id}"`
        #     (for custom dashboards).
        class GetDashboardRequest; end

        # The `DeleteDashboard` request.
        # @!attribute [rw] name
        #   @return [String]
        #     Required. The resource name of the Dashboard. The format is
        #     `"projects/{project_id_or_number}/dashboards/{dashboard_id}"`.
        class DeleteDashboardRequest; end

        # The `UpdateDashboard` request.
        # @!attribute [rw] dashboard
        #   @return [Google::Monitoring::Dashboard::V1::Dashboard]
        #     Required. The dashboard that will replace the existing dashboard.
        class UpdateDashboardRequest; end
      end
    end
  end
end