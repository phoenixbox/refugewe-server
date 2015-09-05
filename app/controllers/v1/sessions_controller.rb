module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # POST /v1/login
    def create
      @user = User.where({uuid: params[:uuid], access_token: params[:access_token]}).take

      return invalid_login_attempt unless @user
      if @user
        # Refresh the token on session creation
        # @user.refresh_access_token
        sign_in :user, @user
        # Implicit namespaced to V1::SessionSerializer
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end

  end
end
