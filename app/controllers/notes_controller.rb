class NotesController < ApplicationController
	def delete
		Note.delete(params[:id])
		render :text => ""
	end

	def update
		@note = Note.find(params[:id])
		@note.update_attributes(:text => params[:text], :start => params[:start])
		render :partial => "notes/partial", :locals => {:note => @note}
	end
end
