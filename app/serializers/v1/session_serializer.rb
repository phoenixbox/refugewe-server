module V1
  class SessionSerializer < ActiveModel::Serializer
    attributes  :access_token,
                :uuid,
                :token_type,
                :user_id,
                :github_username,
                :github_email,
                :github_display_name,
                :github_oauth_token

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end

    # How to hold the once fetched GHA in an ivar so to reduce query count

    def github_username
      github_account.username
    end

    def github_oauth_token
      github_account.token
    end

    def github_email
      github_account.email
    end

    def github_display_name
      github_account.display_name
    end

    def github_account
      auth = object.authentications.find_by_provider('github')
      GithubAccount.find_by_authentication_id(auth.id)
    end
  end
end
