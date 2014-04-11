class ProjectsController < ApplicationController
	def index
		@projects = Project.public_viewing.order("updated_at DESC").all
	end

	def show
		@project = Project.find(params[:id])
        @activities = @project.activities.order("updated_at DESC").all
	end

	def new
        @user = User.find(params[:user_id])
		@project = Project.new
	end

	def create
        # When a project is created 
        @user = User.find(params[:user_id])
        @project = Project.create(params[:project])

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
      @project = Project.find(params[:id])
  end

  def update
      @project = Project.find(params[:id])

      respond_to do |format|
        if @project.update_attributes(params[:project])
            format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
            format.json { head :no_content }
        else
            format.html { render :action => 'edit', alert: 'Project was unsuccessfully updated.' }
            format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
    end
end 

def team
    @project = Project.find(params[:id])
    @owner = User.find(@project.creator_id)
    @members = @project.users_projects
    @usersproject = UsersProject.where(user_id: current_user.id, project_id: @project.id).first
end

def add_member
 UsersProject.in_project(Project.find(1)).count
 @project = Project.find(params[:id])
 @group = Group.where(:name => "Master Group: #{@project.id}").first
 @user = User.where(:email => params[:email]).first
 @usersproject = UsersProject.create(user_id: @user.id, project_id: @project.id, access: params[:users_project][:access])
 @usersgroup = UsersGroup.create(user_id: @user.id, group_id: @group.id, access: 0, notification_level: 0)
respond_to do |format|
    if @usersproject.save && @usersgroup.save
     UserMailer.add_member_email(@user, @project).deliver
     format.html { redirect_to team_project_path(@project), notice: 'Project was successfully updated.' }
 else
     format.html { redirect_to team_project_path(@project), notice: 'Project was unsuccessfully updated.' }

 end
end
end

def remove_member
    @project = Project.find(params[:id])
    @usersproject = UsersProject.find(params[:user_id])
    respond_to do |format|

        if !(@usersproject.owner? && UsersProject.in_project(@project).owners.count <= 1)
            @usersproject.destroy
            format.html { redirect_to team_project_path(@project), notice: 'You successfully removed a member from the project.' }
        else
            # Message that there needs to be at least one owner for the project
            format.html { redirect_to team_project_path(@project), notice: 'There has to be at least one owner of the project at any given time.' }
        end
    end
end

def change_access

end

def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to :back
end

end
