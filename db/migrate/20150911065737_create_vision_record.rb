class CreateVisionRecord < ActiveRecord::Migration
  def change
    create_table :vision_records do |t|
      t.string :DV_OD_SPH
      t.string :DV_OS_SPH
      t.string :DV_OD_CYL
      t.string :DV_OS_CYL
      t.string :DV_OD_AXIS
      t.string :DV_OS_AXIS
      t.string :NV_OD_SPH
      t.string :NV_OS_SPH
      t.string :NV_OD_CYL
      t.string :NV_OS_CYL
      t.string :NV_OD_AXIS
      t.string :NV_OS_AXIS
      t.string :PD
      t.integer :exam_date
      t.integer :expiration_date
      t.belongs_to :mdeical_record, null: false
      t.timestamps null: false
    end
  end
end
