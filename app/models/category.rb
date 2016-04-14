class Category < ActiveRecord::Base
	attr_accessible :name
	has_many :note_collections

	def note_collections_for(user)
		return self.note_collections.where(:user_id=>user.id)
	end
end
