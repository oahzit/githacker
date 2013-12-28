class ProjectsController < ApplicationController
	def index
		@projects = current_user.projects.all
	end

	def show
		@project = Project.find(params[:id])
		@owner = User.find(@project.creator_id)
	end

	def new
		@project = Project.new
	end

	def create
        @project = Project.create(params[:project])

        respond_to do |format|
            if @project.save
                format.html { redirect_to project_path(@project), notice: 'Project was successfully created.' }
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
    @project = Project.find(params[:id])
    @user = User.where(:email => params[:email]).first
    @usersproject = UsersProject.create(user_id: @user.id, project_id: @project.id, access: params[:users_project][:access])
    respond_to do |format|
        if @usersproject.save
           UserMailer.add_member_email(@user, @project).deliver
           format.html { redirect_to team_project_path(@project), notice: 'Project was successfully updated.' }
       else
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
