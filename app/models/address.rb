class Address < ActiveRecord::Base
  ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml", 'r')).map {|country| country["code"] }

  validates :line_1, presence: true
  validates :iso_country_code, presence: true

  as_enum :iso_country_code, ISO_COUNTRY_CODES
end
