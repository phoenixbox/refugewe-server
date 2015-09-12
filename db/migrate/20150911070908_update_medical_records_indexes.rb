class UpdateMedicalRecordsIndexes < ActiveRecord::Migration
  def change
    add_index :medical_records, :gender_cd
    add_index :medical_records, :blood_type_cd
  end
end
