class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.text :description
      t.references :condition, index: true
      t.references :consultation, index: true
      t.timestamps null: false
    end
  end
end
