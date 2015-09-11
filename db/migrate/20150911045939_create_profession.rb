class CreateProfession < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.integer :industry_cd, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :verified, null: false
      t.belongs_to :user, index: true
    end
  end
end
