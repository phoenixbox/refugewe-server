class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.integer :interval_value, index: true
      t.integer :interval_unit_cd, index: true
      t.text :notes
      t.references :dosage, index: true
      t.timestamps
    end
  end
end
