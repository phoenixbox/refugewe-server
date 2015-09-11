class CreateDependents < ActiveRecord::Migration
  def change
    create_table :dependents do |t|
      t.integer :relationship_cd, null: false
      t.integer :source_user_id, null: false
      t.integer :target_user_id, null: false
      t.timestamps null: false
    end
  end
end
