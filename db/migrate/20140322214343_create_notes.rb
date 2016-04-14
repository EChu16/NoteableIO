class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :text
      t.integer :note_collection_id

      t.timestamps
    end
  end
end
