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
      # A single strongly-typed value.
      # @!attribute [rw] bool_value
      #   @return [true, false]
      #     A Boolean value: `true` or `false`.
      # @!attribute [rw] int64_value
      #   @return [Integer]
      #     A 64-bit integer. Its range is approximately &plusmn;9.2x10<sup>18</sup>.
      # @!attribute [rw] double_value
      #   @return [Float]
      #     A 64-bit double-precision floating-point number. Its magnitude
      #     is approximately &plusmn;10<sup>&plusmn;300</sup> and it has 16
      #     significant digits of precision.
      # @!attribute [rw] string_value
      #   @return [String]
      #     A variable-length string value.
      # @!attribute [rw] distribution_value
      #   @return [Google::Api::Distribution]
      #     A distribution value.
      class TypedValue; end

      # A closed time interval. It extends from the start time to the end time, and includes both: `[startTime, endTime]`. Valid time intervals depend on the [`MetricKind`](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.metricDescriptors#MetricKind) of the metric value. In no case can the end time be earlier than the start time.
      #
      # * For a `GAUGE` metric, the `startTime` value is technically optional; if
      #   no value is specified, the start time defaults to the value of the
      #   end time, and the interval represents a single point in time. If both
      #   start and end times are specified, they must be identical. Such an
      #   interval is valid only for `GAUGE` metrics, which are point-in-time
      #   measurements.
      #
      # * For `DELTA` and `CUMULATIVE` metrics, the start time must be earlier
      #   than the end time.
      #
      # * In all cases, the start time of the next interval must be
      #   at least a millisecond after the end time of the previous interval.
      #   Because the interval is closed, if the start time of a new interval
      #   is the same as the end time of the previous interval, data written
      #   at the new start time could overwrite data written at the previous
      #   end time.
      # @!attribute [rw] end_time
      #   @return [Google::Protobuf::Timestamp]
      #     Required. The end of the time interval.
      # @!attribute [rw] start_time
      #   @return [Google::Protobuf::Timestamp]
      #     Optional. The beginning of the time interval.  The default value
      #     for the start time is the end time. The start time must not be
      #     later than the end time.
      class TimeInterval; end

      # Describes how to combine multiple time series to provide a different view of
      # the data.  Aggregation of time series is done in two steps. First, each time
      # series in the set is _aligned_ to the same time interval boundaries, then the
      # set of time series is optionally _reduced_ in number.
      #
      # Alignment consists of applying the `per_series_aligner` operation
      # to each time series after its data has been divided into regular
      # `alignment_period` time intervals. This process takes _all_ of the data
      # points in an alignment period, applies a mathematical transformation such as
      # averaging, minimum, maximum, delta, etc., and converts them into a single
      # data point per period.
      #
      # Reduction is when the aligned and transformed time series can optionally be
      # combined, reducing the number of time series through similar mathematical
      # transformations. Reduction involves applying a `cross_series_reducer` to
      # all the time series, optionally sorting the time series into subsets with
      # `group_by_fields`, and applying the reducer to each subset.
      #
      # The raw time series data can contain a huge amount of information from
      # multiple sources. Alignment and reduction transforms this mass of data into
      # a more manageable and representative collection of data, for example "the
      # 95% latency across the average of all tasks in a cluster". This
      # representative data can be more easily graphed and comprehended, and the
      # individual time series data is still available for later drilldown. For more
      # details, see [Filtering and
      # aggregation](https://cloud.google.com/monitoring/api/v3/aggregation).
      # @!attribute [rw] alignment_period
      #   @return [Google::Protobuf::Duration]
      #     The `alignment_period` specifies a time interval, in seconds, that is used
      #     to divide the data in all the
      #     {Google::Monitoring::V3::TimeSeries time series} into consistent blocks of
      #     time. This will be done before the per-series aligner can be applied to
      #     the data.
      #
      #     The value must be at least 60 seconds. If a per-series aligner other than
      #     `ALIGN_NONE` is specified, this field is required or an error is returned.
      #     If no per-series aligner is specified, or the aligner `ALIGN_NONE` is
      #     specified, then this field is ignored.
      # @!attribute [rw] per_series_aligner
      #   @return [Google::Monitoring::V3::Aggregation::Aligner]
      #     An `Aligner` describes how to bring the data points in a single
      #     time series into temporal alignment. Except for `ALIGN_NONE`, all
      #     alignments cause all the data points in an `alignment_period` to be
      #     mathematically grouped together, resulting in a single data point for
      #     each `alignment_period` with end timestamp at the end of the period.
      #
      #     Not all alignment operations may be applied to all time series. The valid
      #     choices depend on the `metric_kind` and `value_type` of the original time
      #     series. Alignment can change the `metric_kind` or the `value_type` of
      #     the time series.
      #
      #     Time series data must be aligned in order to perform cross-time
      #     series reduction. If `cross_series_reducer` is specified, then
      #     `per_series_aligner` must be specified and not equal to `ALIGN_NONE`
      #     and `alignment_period` must be specified; otherwise, an error is
      #     returned.
      # @!attribute [rw] cross_series_reducer
      #   @return [Google::Monitoring::V3::Aggregation::Reducer]
      #     The reduction operation to be used to combine time series into a single
      #     time series, where the value of each data point in the resulting series is
      #     a function of all the already aligned values in the input time series.
      #
      #     Not all reducer operations can be applied to all time series. The valid
      #     choices depend on the `metric_kind` and the `value_type` of the original
      #     time series. Reduction can yield a time series with a different
      #     `metric_kind` or `value_type` than the input time series.
      #
      #     Time series data must first be aligned (see `per_series_aligner`) in order
      #     to perform cross-time series reduction. If `cross_series_reducer` is
      #     specified, then `per_series_aligner` must be specified, and must not be
      #     `ALIGN_NONE`. An `alignment_period` must also be specified; otherwise, an
      #     error is returned.
      # @!attribute [rw] group_by_fields
      #   @return [Array<String>]
      #     The set of fields to preserve when `cross_series_reducer` is
      #     specified. The `group_by_fields` determine how the time series are
      #     partitioned into subsets prior to applying the aggregation
      #     operation. Each subset contains time series that have the same
      #     value for each of the grouping fields. Each individual time
      #     series is a member of exactly one subset. The
      #     `cross_series_reducer` is applied to each subset of time series.
      #     It is not possible to reduce across different resource types, so
      #     this field implicitly contains `resource.type`.  Fields not
      #     specified in `group_by_fields` are aggregated away.  If
      #     `group_by_fields` is not specified and all the time series have
      #     the same resource type, then the time series are aggregated into
      #     a single output time series. If `cross_series_reducer` is not
      #     defined, this field is ignored.
      class Aggregation
        # The `Aligner` specifies the operation that will be applied to the data
        # points in each alignment period in a time series. Except for
        # `ALIGN_NONE`, which specifies that no operation be applied, each alignment
        # operation replaces the set of data values in each alignment period with
        # a single value: the result of applying the operation to the data values.
        # An aligned time series has a single data value at the end of each
        # `alignment_period`.
        #
        # An alignment operation can change the data type of the values, too. For
        # example, if you apply a counting operation to boolean values, the data
        # `value_type` in the original time series is `BOOLEAN`, but the `value_type`
        # in the aligned result is `INT64`.
        module Aligner
          # No alignment. Raw data is returned. Not valid if cross-series reduction
          # is requested. The `value_type` of the result is the same as the
          # `value_type` of the input.
          ALIGN_NONE = 0

          # Align and convert to
          # {Google::Api::MetricDescriptor::MetricKind::DELTA DELTA}.
          # The output is `delta = y1 - y0`.
          #
          # This alignment is valid for
          # {Google::Api::MetricDescriptor::MetricKind::CUMULATIVE CUMULATIVE} and
          # `DELTA` metrics. If the selected alignment period results in periods
          # with no data, then the aligned value for such a period is created by
          # interpolation. The `value_type`  of the aligned result is the same as
          # the `value_type` of the input.
          ALIGN_DELTA = 1

          # Align and convert to a rate. The result is computed as
          # `rate = (y1 - y0)/(t1 - t0)`, or "delta over time".
          # Think of this aligner as providing the slope of the line that passes
          # through the value at the start and at the end of the `alignment_period`.
          #
          # This aligner is valid for `CUMULATIVE`
          # and `DELTA` metrics with numeric values. If the selected alignment
          # period results in periods with no data, then the aligned value for
          # such a period is created by interpolation. The output is a `GAUGE`
          # metric with `value_type` `DOUBLE`.
          #
          # If, by "rate", you mean "percentage change", see the
          # `ALIGN_PERCENT_CHANGE` aligner instead.
          ALIGN_RATE = 2

          # Align by interpolating between adjacent points around the alignment
          # period boundary. This aligner is valid for `GAUGE` metrics with
          # numeric values. The `value_type` of the aligned result is the same as the
          # `value_type` of the input.
          ALIGN_INTERPOLATE = 3

          # Align by moving the most recent data point before the end of the
          # alignment period to the boundary at the end of the alignment
          # period. This aligner is valid for `GAUGE` metrics. The `value_type` of
          # the aligned result is the same as the `value_type` of the input.
          ALIGN_NEXT_OLDER = 4

          # Align the time series by returning the minimum value in each alignment
          # period. This aligner is valid for `GAUGE` and `DELTA` metrics with
          # numeric values. The `value_type` of the aligned result is the same as
          # the `value_type` of the input.
          ALIGN_MIN = 10

          # Align the time series by returning the maximum value in each alignment
          # period. This aligner is valid for `GAUGE` and `DELTA` metrics with
          # numeric values. The `value_type` of the aligned result is the same as
          # the `value_type` of the input.
          ALIGN_MAX = 11

          # Align the time series by returning the mean value in each alignment
          # period. This aligner is valid for `GAUGE` and `DELTA` metrics with
          # numeric values. The `value_type` of the aligned result is `DOUBLE`.
          ALIGN_MEAN = 12

          # Align the time series by returning the number of values in each alignment
          # period. This aligner is valid for `GAUGE` and `DELTA` metrics with
          # numeric or Boolean values. The `value_type` of the aligned result is
          # `INT64`.
          ALIGN_COUNT = 13

          # Align the time series by returning the sum of the values in each
          # alignment period. This aligner is valid for `GAUGE` and `DELTA`
          # metrics with numeric and distribution values. The `value_type` of the
          # aligned result is the same as the `value_type` of the input.
          ALIGN_SUM = 14

          # Align the time series by returning the standard deviation of the values
          # in each alignment period. This aligner is valid for `GAUGE` and
          # `DELTA` metrics with numeric values. The `value_type` of the output is
          # `DOUBLE`.
          ALIGN_STDDEV = 15

          # Align the time series by returning the number of `True` values in
          # each alignment period. This aligner is valid for `GAUGE` metrics with
          # Boolean values. The `value_type` of the output is `INT64`.
          ALIGN_COUNT_TRUE = 16

          # Align the time series by returning the number of `False` values in
          # each alignment period. This aligner is valid for `GAUGE` metrics with
          # Boolean values. The `value_type` of the output is `INT64`.
          ALIGN_COUNT_FALSE = 24

          # Align the time series by returning the ratio of the number of `True`
          # values to the total number of values in each alignment period. This
          # aligner is valid for `GAUGE` metrics with Boolean values. The output
          # value is in the range [0.0, 1.0] and has `value_type` `DOUBLE`.
          ALIGN_FRACTION_TRUE = 17

          # Align the time series by using [percentile
          # aggregation](https://en.wikipedia.org/wiki/Percentile). The resulting
          # data point in each alignment period is the 99th percentile of all data
          # points in the period. This aligner is valid for `GAUGE` and `DELTA`
          # metrics with distribution values. The output is a `GAUGE` metric with
          # `value_type` `DOUBLE`.
          ALIGN_PERCENTILE_99 = 18

          # Align the time series by using [percentile
          # aggregation](https://en.wikipedia.org/wiki/Percentile). The resulting
          # data point in each alignment period is the 95th percentile of all data
          # points in the period. This aligner is valid for `GAUGE` and `DELTA`
          # metrics with distribution values. The output is a `GAUGE` metric with
          # `value_type` `DOUBLE`.
          ALIGN_PERCENTILE_95 = 19

          # Align the time series by using [percentile
          # aggregation](https://en.wikipedia.org/wiki/Percentile). The resulting
          # data point in each alignment period is the 50th percentile of all data
          # points in the period. This aligner is valid for `GAUGE` and `DELTA`
          # metrics with distribution values. The output is a `GAUGE` metric with
          # `value_type` `DOUBLE`.
          ALIGN_PERCENTILE_50 = 20

          # Align the time series by using [percentile
          # aggregation](https://en.wikipedia.org/wiki/Percentile). The resulting
          # data point in each alignment period is the 5th percentile of all data
          # points in the period. This aligner is valid for `GAUGE` and `DELTA`
          # metrics with distribution values. The output is a `GAUGE` metric with
          # `value_type` `DOUBLE`.
          ALIGN_PERCENTILE_05 = 21

          # Align and convert to a percentage change. This aligner is valid for
          # `GAUGE` and `DELTA` metrics with numeric values. This alignment returns
          # `((current - previous)/previous) * 100`, where the value of `previous` is
          # determined based on the `alignment_period`.
          #
          # If the values of `current` and `previous` are both 0, then the returned
          # value is 0. If only `previous` is 0, the returned value is infinity.
          #
          # A 10-minute moving mean is computed at each point of the alignment period
          # prior to the above calculation to smooth the metric and prevent false
          # positives from very short-lived spikes. The moving mean is only
          # applicable for data whose values are `>= 0`. Any values `< 0` are
          # treated as a missing datapoint, and are ignored. While `DELTA`
          # metrics are accepted by this alignment, special care should be taken that
          # the values for the metric will always be positive. The output is a
          # `GAUGE` metric with `value_type` `DOUBLE`.
          ALIGN_PERCENT_CHANGE = 23
        end

        # A Reducer operation describes how to aggregate data points from multiple
        # time series into a single time series, where the value of each data point
        # in the resulting series is a function of all the already aligned values in
        # the input time series.
        module Reducer
          # No cross-time series reduction. The output of the `Aligner` is
          # returned.
          REDUCE_NONE = 0

          # Reduce by computing the mean value across time series for each
          # alignment period. This reducer is valid for
          # {Google::Api::MetricDescriptor::MetricKind::DELTA DELTA} and
          # {Google::Api::MetricDescriptor::MetricKind::GAUGE GAUGE} metrics with
          # numeric or distribution values. The `value_type` of the output is
          # {Google::Api::MetricDescriptor::ValueType::DOUBLE DOUBLE}.
          REDUCE_MEAN = 1

          # Reduce by computing the minimum value across time series for each
          # alignment period. This reducer is valid for `DELTA` and `GAUGE` metrics
          # with numeric values. The `value_type` of the output is the same as the
          # `value_type` of the input.
          REDUCE_MIN = 2

          # Reduce by computing the maximum value across time series for each
          # alignment period. This reducer is valid for `DELTA` and `GAUGE` metrics
          # with numeric values. The `value_type` of the output is the same as the
          # `value_type` of the input.
          REDUCE_MAX = 3

          # Reduce by computing the sum across time series for each
          # alignment period. This reducer is valid for `DELTA` and `GAUGE` metrics
          # with numeric and distribution values. The `value_type` of the output is
          # the same as the `value_type` of the input.
          REDUCE_SUM = 4

          # Reduce by computing the standard deviation across time series
          # for each alignment period. This reducer is valid for `DELTA` and
          # `GAUGE` metrics with numeric or distribution values. The `value_type`
          # of the output is `DOUBLE`.
          REDUCE_STDDEV = 5

          # Reduce by computing the number of data points across time series
          # for each alignment period. This reducer is valid for `DELTA` and
          # `GAUGE` metrics of numeric, Boolean, distribution, and string
          # `value_type`. The `value_type` of the output is `INT64`.
          REDUCE_COUNT = 6

          # Reduce by computing the number of `True`-valued data points across time
          # series for each alignment period. This reducer is valid for `DELTA` and
          # `GAUGE` metrics of Boolean `value_type`. The `value_type` of the output
          # is `INT64`.
          REDUCE_COUNT_TRUE = 7

          # Reduce by computing the number of `False`-valued data points across time
          # series for each alignment period. This reducer is valid for `DELTA` and
          # `GAUGE` metrics of Boolean `value_type`. The `value_type` of the output
          # is `INT64`.
          REDUCE_COUNT_FALSE = 15

          # Reduce by computing the ratio of the number of `True`-valued data points
          # to the total number of data points for each alignment period. This
          # reducer is valid for `DELTA` and `GAUGE` metrics of Boolean `value_type`.
          # The output value is in the range [0.0, 1.0] and has `value_type`
          # `DOUBLE`.
          REDUCE_FRACTION_TRUE = 8

          # Reduce by computing the [99th
          # percentile](https://en.wikipedia.org/wiki/Percentile) of data points
          # across time series for each alignment period. This reducer is valid for
          # `GAUGE` and `DELTA` metrics of numeric and distribution type. The value
          # of the output is `DOUBLE`.
          REDUCE_PERCENTILE_99 = 9

          # Reduce by computing the [95th
          # percentile](https://en.wikipedia.org/wiki/Percentile) of data points
          # across time series for each alignment period. This reducer is valid for
          # `GAUGE` and `DELTA` metrics of numeric and distribution type. The value
          # of the output is `DOUBLE`.
          REDUCE_PERCENTILE_95 = 10

          # Reduce by computing the [50th
          # percentile](https://en.wikipedia.org/wiki/Percentile) of data points
          # across time series for each alignment period. This reducer is valid for
          # `GAUGE` and `DELTA` metrics of numeric and distribution type. The value
          # of the output is `DOUBLE`.
          REDUCE_PERCENTILE_50 = 11

          # Reduce by computing the [5th
          # percentile](https://en.wikipedia.org/wiki/Percentile) of data points
          # across time series for each alignment period. This reducer is valid for
          # `GAUGE` and `DELTA` metrics of numeric and distribution type. The value
          # of the output is `DOUBLE`.
          REDUCE_PERCENTILE_05 = 12
        end
      end

      # Specifies an ordering relationship on two arguments, called `left` and
      # `right`.
      module ComparisonType
        # No ordering relationship is specified.
        COMPARISON_UNSPECIFIED = 0

        # True if the left argument is greater than the right argument.
        COMPARISON_GT = 1

        # True if the left argument is greater than or equal to the right argument.
        COMPARISON_GE = 2

        # True if the left argument is less than the right argument.
        COMPARISON_LT = 3

        # True if the left argument is less than or equal to the right argument.
        COMPARISON_LE = 4

        # True if the left argument is equal to the right argument.
        COMPARISON_EQ = 5

        # True if the left argument is not equal to the right argument.
        COMPARISON_NE = 6
      end

      # Obsolete.
      module ServiceTier
        # Obsolete.
        SERVICE_TIER_UNSPECIFIED = 0

        # Obsolete.
        SERVICE_TIER_BASIC = 1

        # Obsolete.
        SERVICE_TIER_PREMIUM = 2
      end
    end
  end
end