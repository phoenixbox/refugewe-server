class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name, null: false
      t.integer :type_cd
      t.references :prescription, index: true
      t.timestamps
    end
  end
end
