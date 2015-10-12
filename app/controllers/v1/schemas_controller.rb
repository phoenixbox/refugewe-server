module V1
  class SchemasController < ApplicationController
    # *** address
    ISO_COUNTRY_CODES ||= YAML.load(File.open("#{Rails.root}/config/constants/iso_country_codes.yml", 'r'))
    # type_cd
    ADDRESS_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/address_types.yml", 'r'))
    # *** conditions
    # mdc
    MDC ||= YAML.load(File.open("#{Rails.root}/config/constants/major_diagnostic_categories.yml", "r"))
    # type_cd - (conditions)
    CONDITION_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_types.yml", "r"))
    # stage_cd - (conditions)
    CONDITION_STAGES ||= YAML.load(File.open("#{Rails.root}/config/constants/condition_stages.yml", "r"))
    # *** dependent
    # relationship_cd
    DEPENDENT_RELATIONSHIPS ||= YAML.load(File.open("#{Rails.root}/config/constants/dependent_relationships.yml", 'r'))
    # *** document
    # format_cd - (docs)
    DOCUMENT_FORMATS ||= YAML.load(File.open("#{Rails.root}/config/constants/document_formats.yml", 'r'))
    # category_cd - (docs)
    DOCUMENT_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/document_categories.yml", 'r'))
    # *** dosage
    # unit_cd - (dosage)
    DOSAGE_UNITS ||= YAML.load(File.open("#{Rails.root}/config/constants/dosage_units.yml", "r"))
    # *** drug type
    # type_cd - (drugs)
    DRUG_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/drug_types.yml", "r"))
    # *** instructions
    # interval_unit_cd - (instructions)
    DOSAGE_INTERVALS ||= YAML.load(File.open("#{Rails.root}/config/constants/dosage_intervals.yml", "r"))
    # gender_cd - (medical-record)
    GENDER_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/gender_types.yml", "r"))
    # medical record
    # blood_type_cd - (medical-record)
    BLOOD_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/blood_types.yml", "r"))
    # *** organization
    # role_cd - (organization)
    ORGANIZATION_ROLES ||= YAML.load(File.open("#{Rails.root}/config/constants/organization_roles.yml", 'r'))
    # *** profession
    INDUSTRY_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/industry_types.yml", 'r'))
    # *** resource
    RESOURCE_TYPES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_types.yml","r"))
    RESOURCE_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_categories.yml","r"))
    RESOURCE_SUB_CATEGORIES ||= YAML.load(File.open("#{Rails.root}/config/constants/resource_subcategories.yml","r"))
    # *** user
    MARITAL_STATUSES ||= YAML.load(File.open("#{Rails.root}/config/constants/marital_statuses.yml", 'r'))

    skip_before_action :authenticate_user_from_token!, only: [:index]

    # Use this endpoint to expose the db tables - attrs and types to client
    def index
      @schema ||= ActiveRecord::Base.connection.tables.each_with_object({}) do |table_name, hash|
        # Schema migrations is unnecessary for the response
        unless table_name == 'schema_migrations'
          hash[table_name] = field_type_map(table_name)
          hash[table_name][:associations] = assoc_map(table_name)
        end
      end
      @schema[:enums] = enum_collections

      render json: @schema
    end

    private

    def field_type_map(table_name)
      ActiveRecord::Base.connection.columns(table_name).each_with_object({}) { |c, hash| hash[c.name] = c.type.to_s }
    end

    def assoc_map(table_name)
      table_reflections = table_name.classify.constantize.reflect_on_all_associations
      table_reflections.each_with_object({}) do |reflection, hash|
        hash[reflection.macro] ||= []
        hash[reflection.macro] << reflection.name
      end
    end

    def enum_collections
        {
          :iso_country_code => ISO_COUNTRY_CODES,
          :address_types => ADDRESS_TYPES,
          :mdc => MDC,
          :condition_types => CONDITION_TYPES,
          :condition_stages => CONDITION_STAGES,
          :dependent_relationships => DEPENDENT_RELATIONSHIPS,
          :document_formats => DOCUMENT_FORMATS,
          :document_categories => DOCUMENT_CATEGORIES,
          :dosage_units => DOSAGE_UNITS,
          :dosage_intervals => DOSAGE_INTERVALS,
          :drug_types => DRUG_TYPES,
          :gender_types => GENDER_TYPES,
          :blood_types => BLOOD_TYPES,
          :organization_roles => ORGANIZATION_ROLES,
          :industry_types => INDUSTRY_TYPES,
          :resource_types => RESOURCE_TYPES,
          :resource_categories => RESOURCE_CATEGORIES,
          :resource_sub_categories => RESOURCE_SUB_CATEGORIES,
          :martial_status => MARITAL_STATUSES
        }
    end
  end
end
