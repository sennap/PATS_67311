class NotesController < ApplicationController
	def index
		@notable = find_notable
		@notes = @notable.notes
	end

	def show
		@note = Note.find(params[:id])
	end

	def new 
		@note = Note.new
	end

	def create 
		@notable = find_notable
		@note = @notable.notes.build(params[:note])
		@note.user_id = current_user.id
		@note.date = Date.today
		if @note.save
			flash[:notice] = "Successfully created note."
			noting_on = @note.notable_type.pluralize
			id = @note.notable_id
			eval "redirect_to #{@note.notable_type.downcase}_path(:id=>#{id})"
		else
			render :action => 'new'
		end
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:id])
		if @note.update_attributes(params[:note])
			flash[:notice] = "Successfully updated note."
			redirect_to @note
		else
			render :action => 'edit'
		end
	end

	def destroy 
		@note = Note.find(params[:id])
		@note.destroy
		flash[:notice] = "Succesfully destroyed note."
		redirect_to notes_url
	end

	private
	def find_notable
		params.each do |name, value|	
			if name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
		nil
	end	
end
