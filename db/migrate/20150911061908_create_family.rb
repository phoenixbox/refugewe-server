class CreateFamily < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
