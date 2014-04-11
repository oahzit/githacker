class DiscussionsController < ApplicationController
	def new
		@project = Project.find(params[:project_id])
		@discussion = Discussion.new
	end

	def create
        # When a discussion is created 
        @project = Project.find(params[:project_id])
        @discussion = Discussion.create(params[:discussion])

        # leave a trail when Discussion is created 

        respond_to do |format|
        	if @discussion.save
        		@activity = Activity.new.create_issue!(@project, @discussion)
        		format.html { redirect_to project_discussion_path(@project, @discussion), notice: 'Discussion was successfully created.' }
        		format.json { head :no_content }
        	else
        		format.html { render :action => 'new', alert: 'Discussion was unsuccessfully created.' }
        		format.json { render json: @message.errors, status: :unprocessable_entity }
        	end 
        end
    end

end
