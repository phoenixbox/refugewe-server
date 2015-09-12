class Resource < ActiveRecord::Base
  RESOURCE_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_types.yml","r"))
  RESOURCE_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_categories.yml","r"))
  RESOURCE_SUB_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_subcategories.yml","r"))
  ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml","r")).map {|country| country["code"]}
  # Enums
  as_enum :type, RESOURCE_TYPES
  as_enum :category, RESOURCE_CATEGORIES
  as_enum :sub_category, RESOURCE_SUB_CATEGORIES
  as_enum :country, ISO_COUNTRY_CODES

  # Associations
  belongs_to :user
  belongs_to :resourceable, polymorphic: true
end
