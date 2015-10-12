class Dosage < ActiveRecord::Base
  DOSAGE_UNITS ||= YAML.load(File.open("#{Rails.root}/config/constants/dosage_units.yml", "r"))
  # As Enum
  as_enum :unit, DOSAGE_UNITS
  # Associations
  belongs_to :drug
  belongs_to :prescription

  validates :value, presence: true, numericality: { only_integer: true }
end
