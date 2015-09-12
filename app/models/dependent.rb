class Dependent < ActiveRecord::Base
  DEPENDENT_RELATIONSHIPS ||= YAML.load(File.open("#{Rails.root}/config/constants/dependent_relationships.yml", 'r'))
  # Enums
  as_enum :relationship, DEPENDENT_RELATIONSHIPS
  # Associations
  belongs_to :source_user, class_name: "User"
  belongs_to :target_user, class_name: "User"
end
