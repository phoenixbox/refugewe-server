class AddTimestampsToTables < ActiveRecord::Migration
  def change
    add_column :authentications, :created_at, :datetime, null: false
    add_column :authentications, :updated_at, :datetime, null: false
    add_column :facebook_profiles, :created_at, :datetime, null: false
    add_column :facebook_profiles, :updated_at, :datetime, null: false
  end
end
