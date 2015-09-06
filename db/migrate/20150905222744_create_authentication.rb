class CreateAuthentication < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :token, null: false
      t.integer :user_id, null: false
    end
  end
end
