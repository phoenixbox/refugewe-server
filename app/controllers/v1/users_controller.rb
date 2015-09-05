module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/users
    # ${token} string
    # ${profile} oauth profile - ref below
    # ${provider} string

    # Creates an user
    def create
      @user = User.from_omniauth(user_params)

      if @user.save # The user has either been created or fetched via the auth provider
        render json: @user, serializer: V1::CreateSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private
    # First Level Oauth Keys
    def user_params
      params.require(:user).permit(:token, :provider, :refreshToken, {:profile => facebook_profile_params})
    end
    # Second Level Profile Keys
    def facebook_profile_params
      [:id, :username, :displayName, :email, {:raw => facebook_raw_params} ]
    end
    # Third Level Raw Keys
    def facebook_raw_params
      [
        :name,
        :id
      ]
    end
  end
end

# { --- First Level Oauth Keys ---
#   provider: 'facebook',
#   token: '',
#   refreshToken: undefined,
#   expiresIn: undefined,
#   query: {},
#   profile: { --- Second Level Profile Keys ---
#    id: '123',
#    username: undefined,
#    displayName: 'Shane Rogers',
#    email: undefined,
#    name: {
#     first: undefined,
#     last: undefined,
#     middle: undefined
#    },
#    raw: { --- Third Level Raw Keys ---
#     name: 'Shane Rogers',
#     id: '123'
#    }
#   }
# }
