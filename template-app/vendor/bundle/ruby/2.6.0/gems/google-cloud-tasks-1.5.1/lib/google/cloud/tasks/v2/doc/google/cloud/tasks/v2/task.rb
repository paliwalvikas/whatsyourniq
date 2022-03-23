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
    module Tasks
      module V2
        # A unit of scheduled work.
        # @!attribute [rw] name
        #   @return [String]
        #     Optionally caller-specified in {Google::Cloud::Tasks::V2::CloudTasks::CreateTask CreateTask}.
        #
        #     The task name.
        #
        #     The task name must have the following format:
        #     `projects/PROJECT_ID/locations/LOCATION_ID/queues/QUEUE_ID/tasks/TASK_ID`
        #
        #     * `PROJECT_ID` can contain letters ([A-Za-z]), numbers ([0-9]),
        #       hyphens (-), colons (:), or periods (.).
        #       For more information, see
        #       [Identifying
        #       projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects)
        #     * `LOCATION_ID` is the canonical ID for the task's location.
        #       The list of available locations can be obtained by calling
        #       {Google::Cloud::Location::Locations::ListLocations ListLocations}.
        #       For more information, see https://cloud.google.com/about/locations/.
        #     * `QUEUE_ID` can contain letters ([A-Za-z]), numbers ([0-9]), or
        #       hyphens (-). The maximum length is 100 characters.
        #     * `TASK_ID` can contain only letters ([A-Za-z]), numbers ([0-9]),
        #       hyphens (-), or underscores (_). The maximum length is 500 characters.
        # @!attribute [rw] app_engine_http_request
        #   @return [Google::Cloud::Tasks::V2::AppEngineHttpRequest]
        #     HTTP request that is sent to the App Engine app handler.
        #
        #     An App Engine task is a task that has {Google::Cloud::Tasks::V2::AppEngineHttpRequest AppEngineHttpRequest} set.
        # @!attribute [rw] http_request
        #   @return [Google::Cloud::Tasks::V2::HttpRequest]
        #     HTTP request that is sent to the worker.
        #
        #     An HTTP task is a task that has {Google::Cloud::Tasks::V2::HttpRequest HttpRequest} set.
        # @!attribute [rw] schedule_time
        #   @return [Google::Protobuf::Timestamp]
        #     The time when the task is scheduled to be attempted or retried.
        #
        #     `schedule_time` will be truncated to the nearest microsecond.
        # @!attribute [rw] create_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time that the task was created.
        #
        #     `create_time` will be truncated to the nearest second.
        # @!attribute [rw] dispatch_deadline
        #   @return [Google::Protobuf::Duration]
        #     The deadline for requests sent to the worker. If the worker does not
        #     respond by this deadline then the request is cancelled and the attempt
        #     is marked as a `DEADLINE_EXCEEDED` failure. Cloud Tasks will retry the
        #     task according to the {Google::Cloud::Tasks::V2::RetryConfig RetryConfig}.
        #
        #     Note that when the request is cancelled, Cloud Tasks will stop listing for
        #     the response, but whether the worker stops processing depends on the
        #     worker. For example, if the worker is stuck, it may not react to cancelled
        #     requests.
        #
        #     The default and maximum values depend on the type of request:
        #
        #     * For {Google::Cloud::Tasks::V2::HttpRequest HTTP tasks}, the default is 10 minutes. The deadline
        #       must be in the interval [15 seconds, 30 minutes].
        #
        #     * For {Google::Cloud::Tasks::V2::AppEngineHttpRequest App Engine tasks}, 0 indicates that the
        #       request has the default deadline. The default deadline depends on the
        #       [scaling
        #       type](https://cloud.google.com/appengine/docs/standard/go/how-instances-are-managed#instance_scaling)
        #       of the service: 10 minutes for standard apps with automatic scaling, 24
        #       hours for standard apps with manual and basic scaling, and 60 minutes for
        #       flex apps. If the request deadline is set, it must be in the interval [15
        #       seconds, 24 hours 15 seconds]. Regardless of the task's
        #       `dispatch_deadline`, the app handler will not run for longer than than
        #       the service's timeout. We recommend setting the `dispatch_deadline` to
        #       at most a few seconds more than the app handler's timeout. For more
        #       information see
        #       [Timeouts](https://cloud.google.com/tasks/docs/creating-appengine-handlers#timeouts).
        #
        #     `dispatch_deadline` will be truncated to the nearest millisecond. The
        #     deadline is an approximate deadline.
        # @!attribute [rw] dispatch_count
        #   @return [Integer]
        #     Output only. The number of attempts dispatched.
        #
        #     This count includes attempts which have been dispatched but haven't
        #     received a response.
        # @!attribute [rw] response_count
        #   @return [Integer]
        #     Output only. The number of attempts which have received a response.
        # @!attribute [rw] first_attempt
        #   @return [Google::Cloud::Tasks::V2::Attempt]
        #     Output only. The status of the task's first attempt.
        #
        #     Only {Google::Cloud::Tasks::V2::Attempt#dispatch_time dispatch_time} will be set.
        #     The other {Google::Cloud::Tasks::V2::Attempt Attempt} information is not retained by Cloud Tasks.
        # @!attribute [rw] last_attempt
        #   @return [Google::Cloud::Tasks::V2::Attempt]
        #     Output only. The status of the task's last attempt.
        # @!attribute [rw] view
        #   @return [Google::Cloud::Tasks::V2::Task::View]
        #     Output only. The view specifies which subset of the {Google::Cloud::Tasks::V2::Task Task} has
        #     been returned.
        class Task
          # The view specifies a subset of {Google::Cloud::Tasks::V2::Task Task} data.
          #
          # When a task is returned in a response, not all
          # information is retrieved by default because some data, such as
          # payloads, might be desirable to return only when needed because
          # of its large size or because of the sensitivity of data that it
          # contains.
          module View
            # Unspecified. Defaults to BASIC.
            VIEW_UNSPECIFIED = 0

            # The basic view omits fields which can be large or can contain
            # sensitive data.
            #
            # This view does not include the
            # {Google::Cloud::Tasks::V2::AppEngineHttpRequest#body body in AppEngineHttpRequest}.
            # Bodies are desirable to return only when needed, because they
            # can be large and because of the sensitivity of the data that you
            # choose to store in it.
            BASIC = 1

            # All information is returned.
            #
            # Authorization for {Google::Cloud::Tasks::V2::Task::View::FULL FULL} requires
            # `cloudtasks.tasks.fullView` [Google IAM](https://cloud.google.com/iam/)
            # permission on the {Google::Cloud::Tasks::V2::Queue Queue} resource.
            FULL = 2
          end
        end

        # The status of a task attempt.
        # @!attribute [rw] schedule_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time that this attempt was scheduled.
        #
        #     `schedule_time` will be truncated to the nearest microsecond.
        # @!attribute [rw] dispatch_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time that this attempt was dispatched.
        #
        #     `dispatch_time` will be truncated to the nearest microsecond.
        # @!attribute [rw] response_time
        #   @return [Google::Protobuf::Timestamp]
        #     Output only. The time that this attempt response was received.
        #
        #     `response_time` will be truncated to the nearest microsecond.
        # @!attribute [rw] response_status
        #   @return [Google::Rpc::Status]
        #     Output only. The response from the worker for this attempt.
        #
        #     If `response_time` is unset, then the task has not been attempted or is
        #     currently running and the `response_status` field is meaningless.
        class Attempt; end
      end
    end
  end
end