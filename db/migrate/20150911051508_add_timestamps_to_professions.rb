class AddTimestampsToProfessions < ActiveRecord::Migration
  def change
    add_column :professions, :created_at, :datetime, null: false
    add_column :professions, :updated_at, :datetime, null: false
  end
end
