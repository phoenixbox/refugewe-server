class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.integer :nationality_cd, null: false
      t.integer :primary_address_id
      t.timestamps
    end
    
    add_index :organizations, :primary_address_id
  end
end
