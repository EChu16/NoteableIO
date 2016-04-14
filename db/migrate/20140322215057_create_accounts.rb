class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :provider
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :uid

      t.timestamps
    end
  end
end
