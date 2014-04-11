class IssuesController < ApplicationController
	def display

	end

	def index
		@user = current_user
		@project = Project.find(params[:project_id])
		@issues = @project.discussions.issues.popular.recent.all
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
        @issue = @project.discussions.create(params[:discussions])

        # a group is automatically generated
        @group = Group.create(name: "Master Group: #{@project.id}", owner_id: @user.id)

        # and the user who created it is added to the group and project
        @usersproject = UsersProject.create(user_id: @user.id, project_id: @project.id, access: 0)

        # leave a trail when project is created 
        @activity = Activity.new.create_message!(@user, @project)

        respond_to do |format|
        	if @project.save
        		format.html { redirect_to user_project_path(@user, @project), notice: 'Project was successfully created.' }
        		format.json { head :no_content }
        	else
        		format.html { render :action => 'new', alert: 'Project was unsuccessfully created.' }
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


    def destroy
    	@issue = Discussion.find(params[:id])
    	@issue.destroy
    	redirect_to :back
    end

end
