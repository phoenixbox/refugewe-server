class MoveAddressableToAddress < ActiveRecord::Migration
  def change
    remove_column :users, :addressable_id, :integer
    remove_column :users, :addressable_type, :string
    add_column :addresses, :addressable_id, :integer
    add_column :addresses, :addressable_type, :string
  end
end
