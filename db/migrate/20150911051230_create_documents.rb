class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :format_cd, null: false
      t.integer :category_cd, null: false
      t.string :title
      t.text :description
      t.text :url, null: false
      t.integer :documentable_id
      t.string :documentable_type
      t.timestamps null: false
    end
  end
end
