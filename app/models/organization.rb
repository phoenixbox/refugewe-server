class Organization < ActiveRecord::Base
  ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml", 'r')).map {|country| country["code"] }

  # Validations
  validates :title, presence: true
  # Enums
  as_enum :nationality_cd, ISO_COUNTRY_CODES
  # Associations
  has_many :addresses, as: :addressable
end
