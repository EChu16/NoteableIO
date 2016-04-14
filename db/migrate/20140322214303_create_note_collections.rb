class CreateNoteCollections < ActiveRecord::Migration
  def change
    create_table :note_collections do |t|
      t.string :name
      t.string :noteable_type
      t.integer :noteable_id
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
