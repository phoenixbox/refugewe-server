class AddRolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :roles, :string, array: true, default: [], null: false
    add_column :users, :marital_status_cd, :integer
    add_column :users, :nationality_cd, :integer
    add_index  :users, :roles, using: 'gin'
  end
end
