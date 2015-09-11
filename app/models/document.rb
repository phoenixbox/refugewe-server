class Document < ActiveRecord::Base
  DOCUMENT_FORMATS ||= YAML.load(File.open("#{Rails.root}/config/constants/document_formats.yml", 'r'))
  DOCUMENT_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/document_categories.yml", 'r'))
  # Enums
  as_enum :format_cd, DOCUMENT_FORMATS
  as_enum :category_cd, DOCUMENT_CATEGORIES

  # Associations
  belongs_to :documentable, polymorphic: true
end
