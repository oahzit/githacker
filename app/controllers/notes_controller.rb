class NotesController < ApplicationController
    before_filter :authenticate_user!

	def display

	end

	def index
		@user = current_user
		@project = Project.find(params[:project_id])
		@notes = @project.discussions.notes.order("created_at DESC")
	end

	def show
        @project = Project.find(params[:project_id])
        @note = Discussion.find(params[:id])
        @comments = @note.comments
	end

	def new
		@project = Project.find(params[:project_id])
    	@note = @project.discussions.new
	end

	def create
        # When an note is created 
		@project = Project.find(params[:project_id])
        @note = @project.discussions.create(params[:note])

        respond_to do |format|
        	if @note.save
        		format.html { redirect_to :back, notice: 'Note was successfully created.' }
        		format.json { head :no_content }
        	else
        		format.html { render :action => 'new', alert: 'Note was unsuccessfully created.' }
        		format.json { render json: @message.errors, status: :unprocessable_entity }
        	end 
        end
    end

    def edit
    	@note = Discussion.find(params[:id])
    end

    def update
    	@note = Discussion.find(params[:id])

    	respond_to do |format|
    		if @note.update_attributes(params[:discussion])
    			format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
    			format.json { head :no_content }
    		else
    			format.html { render :action => 'edit', alert: 'Project was unsuccessfully updated.' }
    			format.json { render json: @message.errors, status: :unprocessable_entity }
    		end 
    	end
    end 

    def up_vote
        @note = Discussion.find(params[:id])
        @note.up_vote
        redirect_to :back
    end

    def down_vote
        @note = Discussion.find(params[:id])
        @note.down_vote
        redirect_to :back
    end

    def destroy
    	@note = Discussion.find(params[:id])
    	@note.destroy
    	redirect_to :back
    end

end
