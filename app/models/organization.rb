class Organization < ActiveRecord::Base
  ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml", 'r')).map {|country| country["code"] }

  # Validations
  validates :title, presence: true
  # Enums
  as_enum :nationality, ISO_COUNTRY_CODES
  # Associations
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :organization_users
  has_many :users, through: :organization_users
end
