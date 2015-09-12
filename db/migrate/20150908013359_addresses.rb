class Addresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1, null: false
      t.string :line_2
      t.string :line_3
      t.string :city
      t.string :province
      t.string :zipcode
      t.integer :iso_country_code_cd, null: false
      t.string :type
      t.text :description
      t.timestamps null: false
    end
    add_index :addresses, :iso_country_code_cd
  end
end
