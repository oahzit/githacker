class UsersProjectsController < ApplicationController
	def index
        @user = User.find(params[:user_id])
        @projects = @user.projects.order("updated_at DESC").all
        @users_projects = UsersProject.where(:user_id => @user.id)
        @as_owner = Project.where(:creator_id => @user.id).all
        @as_member = @users_projects.where(:access_level => 1).all
        @as_watcher = @users_projects.where(:access_level => 2).all
    end

    def show
      @project = Project.find(params[:id])
      @owner = User.find(@project.creator_id)
      @activities = @project.activities.order("updated_at DESC").all
  end

  def new
    @user = User.find(params[:user_id])
    @users_project = UsersProject.new
    @project = Project.new
end

def create
        # When a project is created 
        @user = User.find(params[:user_id])

        ActiveRecord::Base.transaction do
            @project = Project.create(params[:users_project][:project])

        # a group is automatically generated
        @group = Group.create!(name: "Master Group", owner_id: @user.id)
        @group.save
        @users_groups = UsersGroup.create!(user_id: @user.id, group_id: @group.id)

        # and the user who created it is added to the group and project
        @users_project = UsersProject.create!(user_id: @user.id, project_id: @project.id)
    end

    respond_to do |format|
        if @project.save
               # leave a trail when project is created 
               @activity = Activity.new.create_message!(@user, @project)
               format.html { redirect_to user_users_projects_path(@user), notice: 'Project was successfully created.' }
               format.json { head :no_content }
           else
            format.html { render :action => 'new', alert: 'Project was unsuccessfully created.' }
            format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
    end

end
end
