class UpdateAddressTypeToEnum < ActiveRecord::Migration
  def change
    remove_column :addresses, :type, :string
    add_column :addresses, :type_cd, :integer, null: false
  end
end
