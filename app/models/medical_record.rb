class MedicalRecord < ActiveRecord::Base
  BLOOD_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/blood_types.yml", "r"))
  GENDER_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/gender_types.yml", "r"))
  # As enum
  as_enum :gender, GENDER_TYPES
  as_enum :blood_type, BLOOD_TYPES
  # Associations
  has_many :documents, as: :documentable
  has_many :consultations
end
