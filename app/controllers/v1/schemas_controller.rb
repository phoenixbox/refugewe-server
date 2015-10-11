module V1
  class SchemasController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    # Use this endpoint to expose the db tables - attrs and types to client
    def index
      @schema = ActiveRecord::Base.connection.tables.each_with_object({}) do |table_name, hash|
        # Schema migrations is unnecessary for the response
        unless table_name == 'schema_migrations'
          hash[table_name] = field_type_map(table_name)
          hash[table_name][:associations] = assoc_map(table_name)
        end
      end

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
  end
end
