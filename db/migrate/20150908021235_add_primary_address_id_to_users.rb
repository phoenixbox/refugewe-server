class AddPrimaryAddressIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_address_id, :integer
    add_index :users, :primary_address_id
  end
end
