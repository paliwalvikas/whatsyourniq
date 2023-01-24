module BxBlockAddProfile
  class AddProfilesController < ApplicationController
    before_action :find_profile, only: %i[show update calculate_bmi destroy]

    def index
      serializer = AddProfileSerializer.new(current_user&.add_profiles, serialization_options).serializable_hash

      render json: serializer, status: :ok
    end

    def create
      add_prfile = current_user&.add_profiles.new(profile_params)
      save_result = add_prfile.save

      if save_result
        render json: AddProfileSerializer.new(add_prfile, serialization_options).serializable_hash,
               status: :created
        AddProfileMailer.new_family_member(current_user, add_prfile).deliver_later
      else
        render json: ErrorSerializer.new(add_prfile, serialization_options).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def update
      update_result = @add_profile.update(profile_params)
      if update_result
        render json: AddProfileSerializer.new(@add_profile, serialization_options)
                         .serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(@add_profile).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def show
      serializer = AddProfileSerializer.new(@add_profile, serialization_options).serializable_hash

      render json: serializer, status: :ok
    end

    def destroy
      @add_profile.destroy
      render json: { success: true, message: I18n.t('controllers.bx_block_add_profile.add_profiles_controller.profile_successfully_deleted') }, status: :ok
    end

    def calculate_bmi
      if params[:height].present? and params[:weight].present?
        @add_profile.height = params[:height]
        @add_profile.weight = params[:weight]

        @add_profile.bmi_result = BmiCalculator.calc_m @add_profile.height, @add_profile.weight

        if @add_profile.bmi_result < 18.50
          @add_profile.bmi_status = 0
        elsif @add_profile.bmi_result >= 18.51 and @add_profile.bmi_result <= 22.90
          @add_profile.bmi_status = 1
        elsif @add_profile.bmi_result >= 22.91 and @add_profile.bmi_result <= 24.90
          @add_profile.bmi_status = 2
        elsif @add_profile.bmi_result >= 24.91 and @add_profile.bmi_result <= 29.90
          @add_profile.bmi_status = 3
        elsif @add_profile.bmi_result >= 29.91
          @add_profile.bmi_status = 4
        end

        if @add_profile.save
          serializer = AddProfileSerializer.new(@add_profile, serialization_options).serializable_hash
          render json: serializer, status: :ok
        else
          render json: {
            message: I18n.t('controllers.bx_block_add_profile.add_profiles_controller.unable_calculate_bmi')
          }, status: :unprocessable_entity
        end
      else
        render json: {
          message: I18n.t('controllers.bx_block_add_profile.add_profiles_controller.provide_requierd_details')
        }, status: :unprocessable_entity
      end
    end

    private 

    def profile_params
      params.permit(
        :full_name, :age, :gender, :email, :height, :weight, :address, :pincode,
        :city, :state, :activity_level, :contact_no, :relation_id, :image
      )
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end

    def find_profile
      @add_profile = BxBlockAddProfile::AddProfile.find_by_id(params[:id] || params[:profile_id])

      unless @add_profile.present?
        return render json: {
            message: I18n.t('controllers.bx_block_add_profile.add_profiles_controller.profile_not_exists')
          }, status: :unprocessable_entity
      end
    end

  end
end
