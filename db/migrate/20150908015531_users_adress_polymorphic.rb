class UsersAdressPolymorphic < ActiveRecord::Migration
  def change
    add_column :users, :addressable_id, :integer
    add_column :users, :addressable_type, :string
    add_index :users, :addressable_id
  end
end
