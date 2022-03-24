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
    module V3
      # The `ListMonitoredResourceDescriptors` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The project on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]
      # @!attribute [rw] filter
      #   @return [String]
      #     An optional [filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     describing the descriptors to be returned.  The filter can reference the
      #     descriptor's type and labels. For example, the following filter returns
      #     only Google Compute Engine descriptors that have an `id` label:
      #
      #         resource.type = starts_with("gce_") AND resource.label:id
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     A positive number that is the maximum number of results to return.
      # @!attribute [rw] page_token
      #   @return [String]
      #     If this field is not empty then it must contain the `nextPageToken` value
      #     returned by a previous call to this method.  Using this field causes the
      #     method to return additional results from the previous method call.
      class ListMonitoredResourceDescriptorsRequest; end

      # The `ListMonitoredResourceDescriptors` response.
      # @!attribute [rw] resource_descriptors
      #   @return [Array<Google::Api::MonitoredResourceDescriptor>]
      #     The monitored resource descriptors that are available to this project
      #     and that match `filter`, if present.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     If there are more results than have been returned, then this field is set
      #     to a non-empty value.  To see the additional results,
      #     use that value as `page_token` in the next call to this method.
      class ListMonitoredResourceDescriptorsResponse; end

      # The `GetMonitoredResourceDescriptor` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The monitored resource descriptor to get.  The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]/monitoredResourceDescriptors/[RESOURCE_TYPE]
      #
      #     The `[RESOURCE_TYPE]` is a predefined type, such as
      #     `cloudsql_database`.
      class GetMonitoredResourceDescriptorRequest; end

      # The `ListMetricDescriptors` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The project on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]
      # @!attribute [rw] filter
      #   @return [String]
      #     If this field is empty, all custom and
      #     system-defined metric descriptors are returned.
      #     Otherwise, the [filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifies which metric descriptors are to be
      #     returned. For example, the following filter matches all
      #     [custom metrics](https://cloud.google.com/monitoring/custom-metrics):
      #
      #         metric.type = starts_with("custom.googleapis.com/")
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     A positive number that is the maximum number of results to return.
      # @!attribute [rw] page_token
      #   @return [String]
      #     If this field is not empty then it must contain the `nextPageToken` value
      #     returned by a previous call to this method.  Using this field causes the
      #     method to return additional results from the previous method call.
      class ListMetricDescriptorsRequest; end

      # The `ListMetricDescriptors` response.
      # @!attribute [rw] metric_descriptors
      #   @return [Array<Google::Api::MetricDescriptor>]
      #     The metric descriptors that are available to the project
      #     and that match the value of `filter`, if present.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     If there are more results than have been returned, then this field is set
      #     to a non-empty value.  To see the additional results,
      #     use that value as `page_token` in the next call to this method.
      class ListMetricDescriptorsResponse; end

      # The `GetMetricDescriptor` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The metric descriptor on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]/metricDescriptors/[METRIC_ID]
      #
      #     An example value of `[METRIC_ID]` is
      #     `"compute.googleapis.com/instance/disk/read_bytes_count"`.
      class GetMetricDescriptorRequest; end

      # The `CreateMetricDescriptor` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The project on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]
      # @!attribute [rw] metric_descriptor
      #   @return [Google::Api::MetricDescriptor]
      #     Required. The new [custom metric](https://cloud.google.com/monitoring/custom-metrics)
      #     descriptor.
      class CreateMetricDescriptorRequest; end

      # The `DeleteMetricDescriptor` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The metric descriptor on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]/metricDescriptors/[METRIC_ID]
      #
      #     An example of `[METRIC_ID]` is:
      #     `"custom.googleapis.com/my_test_metric"`.
      class DeleteMetricDescriptorRequest; end

      # The `ListTimeSeries` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The project on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]
      # @!attribute [rw] filter
      #   @return [String]
      #     Required. A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     that specifies which time series should be returned.  The filter must
      #     specify a single metric type, and can additionally specify metric labels
      #     and other information. For example:
      #
      #         metric.type = "compute.googleapis.com/instance/cpu/usage_time" AND
      #             metric.labels.instance_name = "my-instance-name"
      # @!attribute [rw] interval
      #   @return [Google::Monitoring::V3::TimeInterval]
      #     Required. The time interval for which results should be returned. Only time series
      #     that contain data points in the specified interval are included
      #     in the response.
      # @!attribute [rw] aggregation
      #   @return [Google::Monitoring::V3::Aggregation]
      #     Specifies the alignment of data points in individual time series as
      #     well as how to combine the retrieved time series across specified labels.
      #
      #     By default (if no `aggregation` is explicitly specified), the raw time
      #     series data is returned.
      # @!attribute [rw] order_by
      #   @return [String]
      #     Unsupported: must be left blank. The points in each time series are
      #     currently returned in reverse time order (most recent to oldest).
      # @!attribute [rw] view
      #   @return [Google::Monitoring::V3::ListTimeSeriesRequest::TimeSeriesView]
      #     Required. Specifies which information is returned about the time series.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     A positive number that is the maximum number of results to return. If
      #     `page_size` is empty or more than 100,000 results, the effective
      #     `page_size` is 100,000 results. If `view` is set to `FULL`, this is the
      #     maximum number of `Points` returned. If `view` is set to `HEADERS`, this is
      #     the maximum number of `TimeSeries` returned.
      # @!attribute [rw] page_token
      #   @return [String]
      #     If this field is not empty then it must contain the `nextPageToken` value
      #     returned by a previous call to this method.  Using this field causes the
      #     method to return additional results from the previous method call.
      class ListTimeSeriesRequest
        # Controls which fields are returned by `ListTimeSeries`.
        module TimeSeriesView
          # Returns the identity of the metric(s), the time series,
          # and the time series data.
          FULL = 0

          # Returns the identity of the metric and the time series resource,
          # but not the time series data.
          HEADERS = 1
        end
      end

      # The `ListTimeSeries` response.
      # @!attribute [rw] time_series
      #   @return [Array<Google::Monitoring::V3::TimeSeries>]
      #     One or more time series that match the filter included in the request.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     If there are more results than have been returned, then this field is set
      #     to a non-empty value.  To see the additional results,
      #     use that value as `page_token` in the next call to this method.
      # @!attribute [rw] execution_errors
      #   @return [Array<Google::Rpc::Status>]
      #     Query execution errors that may have caused the time series data returned
      #     to be incomplete.
      class ListTimeSeriesResponse; end

      # The `CreateTimeSeries` request.
      # @!attribute [rw] name
      #   @return [String]
      #     Required. The project on which to execute the request. The format is:
      #
      #         projects/[PROJECT_ID_OR_NUMBER]
      # @!attribute [rw] time_series
      #   @return [Array<Google::Monitoring::V3::TimeSeries>]
      #     Required. The new data to be added to a list of time series.
      #     Adds at most one data point to each of several time series.  The new data
      #     point must be more recent than any other point in its time series.  Each
      #     `TimeSeries` value must fully specify a unique time series by supplying
      #     all label values for the metric and the monitored resource.
      #
      #     The maximum number of `TimeSeries` objects per `Create` request is 200.
      class CreateTimeSeriesRequest; end
    end
  end
end