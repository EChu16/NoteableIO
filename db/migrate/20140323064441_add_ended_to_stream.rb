class AddEndedToStream < ActiveRecord::Migration
  def change
  	add_column :streams, :ended, :boolean
  end
end
