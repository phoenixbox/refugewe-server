class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :phoneable_id
      t.string :phoneable_type
      t.timestamps null: false
    end
  end
end
