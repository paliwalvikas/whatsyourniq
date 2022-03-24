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
        # Describes how to combine multiple time series to provide different views of
        # the data.  Aggregation consists of an alignment step on individual time
        # series (`alignment_period` and `per_series_aligner`) followed by an optional
        # reduction step of the data across the aligned time series
        # (`cross_series_reducer` and `group_by_fields`).  For more details, see
        # [Aggregation](https://cloud.google.com/monitoring/api/learn_more#aggregation).
        # @!attribute [rw] alignment_period
        #   @return [Google::Protobuf::Duration]
        #     The alignment period for per-{TimeSeries time series}
        #     alignment. If present, `alignmentPeriod` must be at least 60
        #     seconds.  After per-time series alignment, each time series will
        #     contain data points only on the period boundaries. If
        #     `perSeriesAligner` is not specified or equals `ALIGN_NONE`, then
        #     this field is ignored. If `perSeriesAligner` is specified and
        #     does not equal `ALIGN_NONE`, then this field must be defined;
        #     otherwise an error is returned.
        # @!attribute [rw] per_series_aligner
        #   @return [Google::Monitoring::Dashboard::V1::Aggregation::Aligner]
        #     The approach to be used to align individual time series. Not all
        #     alignment functions may be applied to all time series, depending
        #     on the metric type and value type of the original time
        #     series. Alignment may change the metric type or the value type of
        #     the time series.
        #
        #     Time series data must be aligned in order to perform cross-time
        #     series reduction. If `crossSeriesReducer` is specified, then
        #     `perSeriesAligner` must be specified and not equal `ALIGN_NONE`
        #     and `alignmentPeriod` must be specified; otherwise, an error is
        #     returned.
        # @!attribute [rw] cross_series_reducer
        #   @return [Google::Monitoring::Dashboard::V1::Aggregation::Reducer]
        #     The approach to be used to combine time series. Not all reducer
        #     functions may be applied to all time series, depending on the
        #     metric type and the value type of the original time
        #     series. Reduction may change the metric type of value type of the
        #     time series.
        #
        #     Time series data must be aligned in order to perform cross-time
        #     series reduction. If `crossSeriesReducer` is specified, then
        #     `perSeriesAligner` must be specified and not equal `ALIGN_NONE`
        #     and `alignmentPeriod` must be specified; otherwise, an error is
        #     returned.
        # @!attribute [rw] group_by_fields
        #   @return [Array<String>]
        #     The set of fields to preserve when `crossSeriesReducer` is
        #     specified. The `groupByFields` determine how the time series are
        #     partitioned into subsets prior to applying the aggregation
        #     function. Each subset contains time series that have the same
        #     value for each of the grouping fields. Each individual time
        #     series is a member of exactly one subset. The
        #     `crossSeriesReducer` is applied to each subset of time series.
        #     It is not possible to reduce across different resource types, so
        #     this field implicitly contains `resource.type`.  Fields not
        #     specified in `groupByFields` are aggregated away.  If
        #     `groupByFields` is not specified and all the time series have
        #     the same resource type, then the time series are aggregated into
        #     a single output time series. If `crossSeriesReducer` is not
        #     defined, this field is ignored.
        class Aggregation
          # The Aligner describes how to bring the data points in a single
          # time series into temporal alignment.
          module Aligner
            # No alignment. Raw data is returned. Not valid if cross-time
            # series reduction is requested. The value type of the result is
            # the same as the value type of the input.
            ALIGN_NONE = 0

            # Align and convert to delta metric type. This alignment is valid
            # for cumulative metrics and delta metrics. Aligning an existing
            # delta metric to a delta metric requires that the alignment
            # period be increased. The value type of the result is the same
            # as the value type of the input.
            #
            # One can think of this aligner as a rate but without time units; that
            # is, the output is conceptually (second_point - first_point).
            ALIGN_DELTA = 1

            # Align and convert to a rate. This alignment is valid for
            # cumulative metrics and delta metrics with numeric values. The output is a
            # gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            #
            # One can think of this aligner as conceptually providing the slope of
            # the line that passes through the value at the start and end of the
            # window. In other words, this is conceptually ((y1 - y0)/(t1 - t0)),
            # and the output unit is one that has a "/time" dimension.
            #
            # If, by rate, you are looking for percentage change, see the
            # `ALIGN_PERCENT_CHANGE` aligner option.
            ALIGN_RATE = 2

            # Align by interpolating between adjacent points around the
            # period boundary. This alignment is valid for gauge
            # metrics with numeric values. The value type of the result is the same
            # as the value type of the input.
            ALIGN_INTERPOLATE = 3

            # Align by shifting the oldest data point before the period
            # boundary to the boundary. This alignment is valid for gauge
            # metrics. The value type of the result is the same as the
            # value type of the input.
            ALIGN_NEXT_OLDER = 4

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the minimum of all data points in the
            # period. This alignment is valid for gauge and delta metrics with numeric
            # values. The value type of the result is the same as the value
            # type of the input.
            ALIGN_MIN = 10

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the maximum of all data points in the
            # period. This alignment is valid for gauge and delta metrics with numeric
            # values. The value type of the result is the same as the value
            # type of the input.
            ALIGN_MAX = 11

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the average or arithmetic mean of all
            # data points in the period. This alignment is valid for gauge and delta
            # metrics with numeric values. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_MEAN = 12

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the count of all data points in the
            # period. This alignment is valid for gauge and delta metrics with numeric
            # or Boolean values. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            ALIGN_COUNT = 13

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the sum of all data points in the
            # period. This alignment is valid for gauge and delta metrics with numeric
            # and distribution values. The value type of the output is the
            # same as the value type of the input.
            ALIGN_SUM = 14

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the standard deviation of all data
            # points in the period. This alignment is valid for gauge and delta metrics
            # with numeric values. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_STDDEV = 15

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the count of True-valued data points in the
            # period. This alignment is valid for gauge metrics with
            # Boolean values. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            ALIGN_COUNT_TRUE = 16

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the count of False-valued data points in the
            # period. This alignment is valid for gauge metrics with
            # Boolean values. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            ALIGN_COUNT_FALSE = 24

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the fraction of True-valued data points in the
            # period. This alignment is valid for gauge metrics with Boolean values.
            # The output value is in the range [0, 1] and has value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_FRACTION_TRUE = 17

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the 99th percentile of all data
            # points in the period. This alignment is valid for gauge and delta metrics
            # with distribution values. The output is a gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_PERCENTILE_99 = 18

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the 95th percentile of all data
            # points in the period. This alignment is valid for gauge and delta metrics
            # with distribution values. The output is a gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_PERCENTILE_95 = 19

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the 50th percentile of all data
            # points in the period. This alignment is valid for gauge and delta metrics
            # with distribution values. The output is a gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_PERCENTILE_50 = 20

            # Align time series via aggregation. The resulting data point in
            # the alignment period is the 5th percentile of all data
            # points in the period. This alignment is valid for gauge and delta metrics
            # with distribution values. The output is a gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_PERCENTILE_05 = 21

            # Align and convert to a percentage change. This alignment is valid for
            # gauge and delta metrics with numeric values. This alignment conceptually
            # computes the equivalent of "((current - previous)/previous)*100"
            # where previous value is determined based on the alignmentPeriod.
            # In the event that previous is 0 the calculated value is infinity with the
            # exception that if both (current - previous) and previous are 0 the
            # calculated value is 0.
            # A 10 minute moving mean is computed at each point of the time window
            # prior to the above calculation to smooth the metric and prevent false
            # positives from very short lived spikes.
            # Only applicable for data that is >= 0. Any values < 0 are treated as
            # no data. While delta metrics are accepted by this alignment special care
            # should be taken that the values for the metric will always be positive.
            # The output is a gauge metric with value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            ALIGN_PERCENT_CHANGE = 23
          end

          # A Reducer describes how to aggregate data points from multiple
          # time series into a single time series.
          module Reducer
            # No cross-time series reduction. The output of the aligner is
            # returned.
            REDUCE_NONE = 0

            # Reduce by computing the mean across time series for each
            # alignment period. This reducer is valid for delta and
            # gauge metrics with numeric or distribution values. The value type of the
            # output is {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            REDUCE_MEAN = 1

            # Reduce by computing the minimum across time series for each
            # alignment period. This reducer is valid for delta and
            # gauge metrics with numeric values. The value type of the output
            # is the same as the value type of the input.
            REDUCE_MIN = 2

            # Reduce by computing the maximum across time series for each
            # alignment period. This reducer is valid for delta and
            # gauge metrics with numeric values. The value type of the output
            # is the same as the value type of the input.
            REDUCE_MAX = 3

            # Reduce by computing the sum across time series for each
            # alignment period. This reducer is valid for delta and
            # gauge metrics with numeric and distribution values. The value type of
            # the output is the same as the value type of the input.
            REDUCE_SUM = 4

            # Reduce by computing the standard deviation across time series
            # for each alignment period. This reducer is valid for delta
            # and gauge metrics with numeric or distribution values. The value type of
            # the output is {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            REDUCE_STDDEV = 5

            # Reduce by computing the count of data points across time series
            # for each alignment period. This reducer is valid for delta
            # and gauge metrics of numeric, Boolean, distribution, and string value
            # type. The value type of the output is
            # {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            REDUCE_COUNT = 6

            # Reduce by computing the count of True-valued data points across time
            # series for each alignment period. This reducer is valid for delta
            # and gauge metrics of Boolean value type. The value type of
            # the output is {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            REDUCE_COUNT_TRUE = 7

            # Reduce by computing the count of False-valued data points across time
            # series for each alignment period. This reducer is valid for delta
            # and gauge metrics of Boolean value type. The value type of
            # the output is {Google::Api::MetricDescriptor::ValueType::INT64 INT64}.
            REDUCE_COUNT_FALSE = 15

            # Reduce by computing the fraction of True-valued data points across time
            # series for each alignment period. This reducer is valid for delta
            # and gauge metrics of Boolean value type. The output value is in the
            # range [0, 1] and has value type
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
            REDUCE_FRACTION_TRUE = 8

            # Reduce by computing 99th percentile of data points across time series
            # for each alignment period. This reducer is valid for gauge and delta
            # metrics of numeric and distribution type. The value of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}
            REDUCE_PERCENTILE_99 = 9

            # Reduce by computing 95th percentile of data points across time series
            # for each alignment period. This reducer is valid for gauge and delta
            # metrics of numeric and distribution type. The value of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}
            REDUCE_PERCENTILE_95 = 10

            # Reduce by computing 50th percentile of data points across time series
            # for each alignment period. This reducer is valid for gauge and delta
            # metrics of numeric and distribution type. The value of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}
            REDUCE_PERCENTILE_50 = 11

            # Reduce by computing 5th percentile of data points across time series
            # for each alignment period. This reducer is valid for gauge and delta
            # metrics of numeric and distribution type. The value of the output is
            # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}
            REDUCE_PERCENTILE_05 = 12
          end
        end

        # Describes a ranking-based time series filter. Each input time series is
        # ranked with an aligner. The filter lets through up to `num_time_series` time
        # series, selecting them based on the relative ranking.
        # @!attribute [rw] ranking_method
        #   @return [Google::Monitoring::Dashboard::V1::PickTimeSeriesFilter::Method]
        #     `rankingMethod` is applied to each time series independently to produce the
        #     value which will be used to compare the time series to other time series.
        # @!attribute [rw] num_time_series
        #   @return [Integer]
        #     How many time series to return.
        # @!attribute [rw] direction
        #   @return [Google::Monitoring::Dashboard::V1::PickTimeSeriesFilter::Direction]
        #     How to use the ranking to select time series that pass through the filter.
        class PickTimeSeriesFilter
          # Describes the ranking directions.
          module Direction
            # Not allowed in well-formed requests.
            DIRECTION_UNSPECIFIED = 0

            # Pass the highest ranking inputs.
            TOP = 1

            # Pass the lowest ranking inputs.
            BOTTOM = 2
          end

          # The value reducers that can be applied to a PickTimeSeriesFilter.
          module Method
            # Not allowed in well-formed requests.
            METHOD_UNSPECIFIED = 0

            # Select the mean of all values.
            METHOD_MEAN = 1

            # Select the maximum value.
            METHOD_MAX = 2

            # Select the minimum value.
            METHOD_MIN = 3

            # Compute the sum of all values.
            METHOD_SUM = 4

            # Select the most recent value.
            METHOD_LATEST = 5
          end
        end

        # A filter that ranks streams based on their statistical relation to other
        # streams in a request.
        # @!attribute [rw] ranking_method
        #   @return [Google::Monitoring::Dashboard::V1::StatisticalTimeSeriesFilter::Method]
        #     `rankingMethod` is applied to a set of time series, and then the produced
        #     value for each individual time series is used to compare a given time
        #     series to others.
        #     These are methods that cannot be applied stream-by-stream, but rather
        #     require the full context of a request to evaluate time series.
        # @!attribute [rw] num_time_series
        #   @return [Integer]
        #     How many time series to output.
        class StatisticalTimeSeriesFilter
          # The filter methods that can be applied to a stream.
          module Method
            # Not allowed in well-formed requests.
            METHOD_UNSPECIFIED = 0

            # Compute the outlier score of each stream.
            METHOD_CLUSTER_OUTLIER = 1
          end
        end
      end
    end
  end
end