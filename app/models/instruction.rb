class Instruction < ActiveRecord::Base
  DOSAGE_INTERVALS ||= YAML.load(File.open("#{Rails.root}/config/constants/dosage_intervals.yml", "r"))
  # Enums
  as_enum :interval_unit, DOSAGE_INTERVALS
  # Associations
  belongs_to :dosage
end
