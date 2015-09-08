class OrganizationUser < ActiveRecord::Base
  ORGANIZATION_ROLES ||= YAML.load(File.open("#{Rails.root}/config/constants/organization_roles.yml", 'r'))

  belongs_to :user, dependent: :destroy
  belongs_to :organization, dependent: :destroy
  as_enum :role, ORGANIZATION_ROLES
end
