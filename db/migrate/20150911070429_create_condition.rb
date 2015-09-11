class CreateCondition < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.belongs_to :medical_record
      t.integer :type_cd, index: true
      t.integer :stage_cd, index: true
      t.integer :mdc_cd, index: true
      t.integer :mdc_description_cd, index: true
      t.timestamps null: false
    end
  end
end
