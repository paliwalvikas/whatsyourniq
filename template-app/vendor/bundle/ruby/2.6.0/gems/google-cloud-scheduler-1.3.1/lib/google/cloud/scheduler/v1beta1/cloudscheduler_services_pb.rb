# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: google/cloud/scheduler/v1beta1/cloudscheduler.proto for package 'google.cloud.scheduler.v1beta1'
# Original file comments:
# Copyright 2019 Google LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#


require 'grpc'
require 'google/cloud/scheduler/v1beta1/cloudscheduler_pb'

module Google
  module Cloud
    module Scheduler
      module V1beta1
        module CloudScheduler
          # The Cloud Scheduler API allows external entities to reliably
          # schedule asynchronous jobs.
          class Service

            include GRPC::GenericService

            self.marshal_class_method = :encode
            self.unmarshal_class_method = :decode
            self.service_name = 'google.cloud.scheduler.v1beta1.CloudScheduler'

            # Lists jobs.
            rpc :ListJobs, ListJobsRequest, ListJobsResponse
            # Gets a job.
            rpc :GetJob, GetJobRequest, Job
            # Creates a job.
            rpc :CreateJob, CreateJobRequest, Job
            # Updates a job.
            #
            # If successful, the updated [Job][google.cloud.scheduler.v1beta1.Job] is returned. If the job does
            # not exist, `NOT_FOUND` is returned.
            #
            # If UpdateJob does not successfully return, it is possible for the
            # job to be in an [Job.State.UPDATE_FAILED][google.cloud.scheduler.v1beta1.Job.State.UPDATE_FAILED] state. A job in this state may
            # not be executed. If this happens, retry the UpdateJob request
            # until a successful response is received.
            rpc :UpdateJob, UpdateJobRequest, Job
            # Deletes a job.
            rpc :DeleteJob, DeleteJobRequest, Google::Protobuf::Empty
            # Pauses a job.
            #
            # If a job is paused then the system will stop executing the job
            # until it is re-enabled via [ResumeJob][google.cloud.scheduler.v1beta1.CloudScheduler.ResumeJob]. The
            # state of the job is stored in [state][google.cloud.scheduler.v1beta1.Job.state]; if paused it
            # will be set to [Job.State.PAUSED][google.cloud.scheduler.v1beta1.Job.State.PAUSED]. A job must be in [Job.State.ENABLED][google.cloud.scheduler.v1beta1.Job.State.ENABLED]
            # to be paused.
            rpc :PauseJob, PauseJobRequest, Job
            # Resume a job.
            #
            # This method reenables a job after it has been [Job.State.PAUSED][google.cloud.scheduler.v1beta1.Job.State.PAUSED]. The
            # state of a job is stored in [Job.state][google.cloud.scheduler.v1beta1.Job.state]; after calling this method it
            # will be set to [Job.State.ENABLED][google.cloud.scheduler.v1beta1.Job.State.ENABLED]. A job must be in
            # [Job.State.PAUSED][google.cloud.scheduler.v1beta1.Job.State.PAUSED] to be resumed.
            rpc :ResumeJob, ResumeJobRequest, Job
            # Forces a job to run now.
            #
            # When this method is called, Cloud Scheduler will dispatch the job, even
            # if the job is already running.
            rpc :RunJob, RunJobRequest, Job
          end

          Stub = Service.rpc_stub_class
        end
      end
    end
  end
end
