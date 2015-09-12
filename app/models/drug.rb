class Drug < ActiveRecord::Base
  DRUG_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/drug_types.yml", "r"))
  # Enums
  as_enum :type, DRUG_TYPES
  # Associations
  belongs_to :prescription
end
