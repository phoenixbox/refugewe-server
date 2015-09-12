class CreateDosages < ActiveRecord::Migration
  def change
    create_table :dosages do |t|
      t.integer :value
      t.integer :unit_cd, index: true
      t.references :drug, index: true
      t.references :prescription, index: true
      t.timestamps
    end
  end
end
