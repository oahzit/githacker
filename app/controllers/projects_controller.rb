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
        @usersproject = UsersProject.create(user_id: @user.id, project_id: @project.id)
        if @usersproject.save
           format.html { redirect_to team_project_path(@project), notice: 'Member was successfully added.' }
        else
        end
    end

    def remove_member
        @usersproject = UsersProject.find(params[:id])
        if !@usersproject.owner?
        @usersproject.destroy
        flash[:notice] = "You successfully removed a member from the project."
        redirect_to :back
        else
            # Message that there needs to be at least one owner for the project
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
