class AddPasswordToStream < ActiveRecord::Migration
  def change
  	add_column :streams, :password, :string
	add_column :streams, :salt, :string
  end
end
