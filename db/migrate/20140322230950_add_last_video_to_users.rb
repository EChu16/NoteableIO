class AddLastVideoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :last_video_id, :integer
  end
end
