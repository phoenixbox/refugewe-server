class User < ActiveRecord::Base
  ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml", 'r')).map {|country| country["code"] }
  MARITAL_STATUSES ||= YAML.load(File.open("#{Rails.root}/config/constants/marital_statuses.yml", 'r'))

  devise :database_authenticatable, :recoverable, :validatable
  after_create :update_access_token!

  # Validations
  validates :display_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  as_enum :martial_status, MARITAL_STATUSES
  as_enum :nationality, ISO_COUNTRY_CODES

  # Associations
  has_many :authentications


  def self.from_omniauth(params)
    password = Devise.friendly_token[0,20]
    user = User.create!({
      :email => params['profile']['email'],
      :display_name => params['profile']['name'],
      :uuid => "",
      :password => password,
      :password_confirmation => password
    })

    user.createAuthentication(params)
    user
  end

  def createAuthentication(params)
    auth = self.authentications.create({
      :uid => params['profile']['id'],
      :provider => params['provider'],
      :token => params['profile']['token'],
      :token_type => params['profile']['token_type'],
      :expiration => params['profile']['expiration']
    })

    createFacebookProfile(auth, params)
  end

  def createFacebookProfile(auth, params)
    FacebookProfile.create({
      :uid => params['profile']['id'],
      :username => params['profile']['username'],
      :display_name => params['profile']['name'],
      :email => params['profile']['email'],
      :raw => params['profile']['raw'],
      :token => auth.token,
      :authentication_id => auth.id
    })
  end
  # Refresh the token per request
  # def refresh_access_token
  #   self.access_token = "#{self.uuid}:#{Devise.friendly_token}"
  #   save
  # end

  private

  def update_access_token!
    # Do I have access to the original params? or do they need to be passed in?
    uuid = SecureRandom.base64
    self.uuid = uuid
    self.access_token = generate_access_token(uuid)
    save
  end

  def generate_access_token(uuid)
    loop do
      token = "#{uuid}:#{Devise.friendly_token}"
      break token unless User.where(access_token: token).first
    end
  end
end
