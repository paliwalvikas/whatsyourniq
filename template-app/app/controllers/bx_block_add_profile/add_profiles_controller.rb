module BxBlockAddProfile
  class AddProfilesController < ApplicationController
    before_action :find_profile, only: %i[show update]

    def index
      serializer = AddProfileSerializer.new(AddProfile.all, serialization_options).serializable_hash

      render json: serializer, status: :ok
    end

    def create
      add_prfile = AddProfile.new(prfile_params.merge(account_id: current_user.id))
      save_result = add_prfile.save

      if save_result
        render json: AddProfileSerializer.new(add_prfile, serialization_options).serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(add_prfile, serialization_options).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def update
      update_result = @profile.update(prfile_params)
      if update_result
        render json: AddProfileSerializer.new(@profile, serialization_options)
                         .serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(@profile).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def show 
      serializer = AddProfileSerializer.new(@profile, serialization_options).serializable_hash

      render json: serializer, status: :ok
    end

    private 

    def prfile_params
      params.permit(:full_name, :age, :gender, :email, :height, :weight, :address, :pincode, :city, :state, :activity_level,:contact_no, :relation_id, :image)
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end

    def find_profile
      @profile = AddProfile.find_by_id(params[:id])
    end

  end
end
