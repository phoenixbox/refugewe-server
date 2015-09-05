class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :uuid, :string
    add_column :users, :access_token, :string
  end
end
