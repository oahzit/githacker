class DiscussionsController < ApplicationController
    before_filter :authenticate_user!

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

    def edit
        @discussion = Discussion.find(params[:id])
        @discussion.update_attributes(params[:discussion])
        d
    end

    def update
 if @discussion.update_attributes(params[:discussion])
    respond_to do |format|
      format.html {
                  flash[:success] = "Discussion was updated successfully."
                  redirect_to discussions_path
      }
      format.js
    end
  else
    respond_to do |format|
      format.html {
                  flash[:error] = @discussion.errors.present? ? @discussion.errors.full_messages.join('<br />') : "Oops! There is some problem with category update."
                  render :edit
      }
      format.js
    end
  end
    end

    def up_vote
        @discussion = Discussion.find(params[:id])
        @discussion.up_vote
        redirect_to :back
    end

    def down_vote
        @discussion = Discussion.find(params[:id])
        @discussion.down_vote
        redirect_to :back
    end


    def destroy
        @discussion = Discussion.find(params[:id])
        @discussion.destroy
        redirect_to :back
    end
end
