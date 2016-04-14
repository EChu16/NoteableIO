class NoteCollection < ActiveRecord::Base
	attr_accessible :category_id, :name, :noteable_id, :noteable_type, :user_id
	belongs_to :category
	belongs_to :user
	belongs_to :noteable, :polymorphic => true
	has_many :notes
end
