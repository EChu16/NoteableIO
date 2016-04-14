class AddStartAndEndToNote < ActiveRecord::Migration
  def change
  	add_column :notes, :end, :string
  	add_column :notes, :start, :string

  end
end
