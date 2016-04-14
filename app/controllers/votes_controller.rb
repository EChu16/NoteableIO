class VotesController < ApplicationController
	before_filter :require_user!

	def vote
		@note_collection = NoteCollection.find(params[:note_collection_id])
		unless @note_collection.user_id == current_user.id
			@vote = Vote.where(:note_collection_id => params[:note_collection_id], :user_id => current_user.id).first_or_initialize
			@vote.up = params[:up] == "true"
			@vote.save
		end
		render :text=>""
	end
end
