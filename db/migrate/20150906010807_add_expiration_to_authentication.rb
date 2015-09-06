class AddExpirationToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :expiration, :integer
    add_column :authentications, :token_type, :string
  end
end
