class CreateMedicalRecord < ActiveRecord::Migration
  def change
    create_table :medical_records do |t|
      t.belongs_to :user, index: true
      t.integer :dob
      t.integer :gender_cd
      t.integer :blood_type_cd
      t.timestamps null: false
    end
  end
end
