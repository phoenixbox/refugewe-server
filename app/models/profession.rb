class Profession < ActiveRecord::Base
  INDUSTRY_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/industry_types.yml", 'r'))

  # Validations
  validates :title, presence: true
  validates :verified, presence: true
  validates :type_cd, presence: true

  # Enums
  as_enum :industry_cd, INDUSTRY_TYPES

  # Associations
  belongs_to :user
  has_many :documents, as: :documentable
end
