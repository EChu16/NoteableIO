class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :subscriber_id
      t.string :type

      t.timestamps
    end
  end
end
