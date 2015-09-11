class Condition < ActiveRecord::Base
  CONDITION_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_types.yml", "r"))
  CONDITION_STAGES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_stages.yml", "r"))
  # As enum
  as_enum :type, CONDITION_TYPES
  as_enum :stages, CONDITION_STAGES
  # Associations
  belongs_to :medical_record
end
