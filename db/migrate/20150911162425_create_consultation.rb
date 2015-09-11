class CreateConsultation < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.text :description
      t.references :medical_record, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
