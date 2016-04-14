class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :name
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
  end
end
