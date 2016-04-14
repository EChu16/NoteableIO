class AddSessionToStream < ActiveRecord::Migration
  def change
  	add_column :streams, :session, :string
  end
end
