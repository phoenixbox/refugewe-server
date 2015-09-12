class CreateFamilyUsers < ActiveRecord::Migration
  def change
    create_table :family_users do |t|
      t.belongs_to :family, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
