class IssuesController < ApplicationController
	def display
        @user = User.find(params[:user_id])
        @issues = @user.issues
    end

    def index
      @user = current_user
      @project = Project.find(params[:project_id])
      @issues = @project.discussions.issues.recent.popular
  end

  def show
    @project = Project.find(params[:project_id])
    @issue = Discussion.find(params[:id])
    @comments = @issue.comments
end

def new
  @project = Project.find(params[:project_id])
  @issue = @project.discussions.new
end

def create
        # When an issue is created 
        @project = Project.find(params[:project_id])
        @issue = @project.discussions.create(params[:issue])

        respond_to do |format|
            if @issue.save
                format.html { redirect_to :back, notice: 'Issue was successfully created.' }
                format.json { head :no_content }
            else
                format.html { render :action => 'new', alert: 'Issue was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end

    def edit
    	@issue = Discussion.find(params[:id])
    end

    def update
    	@issue = Discussion.find(params[:id])

    	respond_to do |format|
    		if @issue.update_attributes(params[:discussion])
    			format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
    			format.json { head :no_content }
    		else
    			format.html { render :action => 'edit', alert: 'Project was unsuccessfully updated.' }
    			format.json { render json: @message.errors, status: :unprocessable_entity }
    		end 
    	end
    end 

    def up_vote
        @issue = Discussion.find(params[:id])
        @issue.up_vote
        redirect_to :back
    end

    def down_vote
        @issue = Discussion.find(params[:id])
        @issue.down_vote
        redirect_to :back
    end

    def destroy
    	@issue = Discussion.find(params[:id])
    	@issue.destroy
    	redirect_to :back
    end

end
