class Condition < ActiveRecord::Base
  CONDITION_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_types.yml", "r"))
  CONDITION_STAGES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_stages.yml", "r"))
  MDC ||= YAML.load(File.open("#{Rails.root}/config/constants/major_diagnostic_categories.yml", "r"))
  MDC_INDEXES ||= MDC.map {|category| category["index"] }
  MDC_DESCS ||= MDC.map {|category| category["description"] }
  # As enum
  as_enum :type, CONDITION_TYPES
  as_enum :mdc, MDC_INDEXES
  as_enum :mdc_description, MDC_DESCS
  # Associations
  belongs_to :medical_record
end
