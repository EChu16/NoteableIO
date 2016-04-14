class VideosController < ApplicationController
	before_filter :require_user!

	def show
		if params[:url]
			@video = Video.find_by_url(params[:url]) || Video.new(:url=>params[:url])
			@video.save
		elsif current_user
			if current_user.last_video_id
				redirect_to "/videos/" + current_user.last_video.url
			end
		end

		if @video && current_user
			current_user.last_video_id = @video.id
			current_user.save
		end
	end

	def view_notes
		@user = User.find(params[:user_id])
		@video = Video.find_by_url(params[:id])
	end

	def copy_notes
		@video = Video.find_by_url(params[:id])
		@notes_collection = User.find(params[:user_id]).note_collection_for(@video)
		@new_notes_collection = current_user.note_collection_for(@video)
		@notes_collection.notes.each do |note|
			new_note = note.dup
			new_note.note_collection = @new_notes_collection
			new_note.save
		end
		flash[:note] = "Notes copied"
		redirect_to @video
	end

	def save_note
		@video = Video.find_by_url(params[:url])
		@collection = current_user.note_collection_for(@video)
		unless @collection
			@collection = NoteCollection.new
			@collection.user = current_user
			@collection.noteable = @video
			@collection.save
		end
		@note = Note.new(:text => params[:text], :start => params[:start], :note_collection_id => @collection.id)
		@note.save
		render :partial => "notes/partial", :locals => {:note => @note}
	end
end
