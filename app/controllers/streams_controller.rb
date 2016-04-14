class StreamsController < ApplicationController
	before_filter :require_user!
	before_filter :config_opentok

	def create
		session = @opentok.create_session.to_s
		@stream = Stream.new(:user_id => current_user, :session => session, :name=>params[:name])
		if params[:enable_password]
			@stream.set_password(params[:password])
		end
		@stream.ended = false
		@stream.save
		@stream.user.subscriptions.each do |subscription|
			subscription.notify_subscriber(@stream)
		end
		redirect_to "/streams/#{@stream.id}/stream"
	end

	def view_notes
		@user = User.find(params[:user_id])
		@video = Video.find(params[:id])
	end

	def copy_notes
		@stream = Stream.find(params[:id])
		@notes_collection = User.find(params[:user_id]).note_collection_for(@stream)
		@new_notes_collection = current_user.note_collection_for(@stream)
		@notes_collection.notes.each do |note|
			new_note = note.dup
			new_note.note_collection = @new_notes_collection
			new_note.save
		end
		flash[:note] = "Notes copied"
		redirect_to @stream
	end

	def stream
		@stream = Stream.find(params[:id])
		redirect_to "/streams/" + @stream.id unless current_user.id == @stream.user_id
		@token = @opentok.generate_token(:session_id=>@stream.session)
	end

	def show
		@stream = Stream.find(params[:id])
		if !@stream.password.nil?
			if params[:password]
				if !@stream.password_correct?(params[:password])
					flash[:error] = "Incorrect password."
					redirect_to request.original_url
				end
			else
				render "/streams/password_entry"
			end
		end
		@token = @opentok.generate_token(:session_id=>@stream.session)
	end

	def end
		@stream = Stream.find(params[:id])
		@stream.ended = true
		@stream.save
		redirect_to root_url
	end

	def save_note
		@stream = Stream.find(params[:id])
		@collection = current_user.note_collection_for(@stream)
		unless @collection
			@collection = NoteCollection.new
			@collection.user = current_user
			@collection.noteable = @stream
			@collection.save
		end
		@note = Note.new(:text => params[:text], :start => params[:start], :note_collection_id => @collection.id)
		@note.save
		render :partial => "notes/partial", :locals => {:note => @note}
	end

	def config_opentok
    		if @opentok.nil?
    			@opentok = OpenTok::OpenTokSDK.new(44704242, "27928ff94ea9457b852575cc8c941b6f252dc057")
   		end
 	end

end
