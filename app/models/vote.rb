class Vote < ActiveRecord::Base
	attr_accessible :note_collection_id, :up

	belongs_to :user
	belongs_to :note_collection
end
