class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :city
      t.string :unit
      t.integer :value
      t.integer :type_cd, index: true
      t.integer :category_cd, index: true
      t.integer :sub_category_cd, index: true
      t.integer :country_cd, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
