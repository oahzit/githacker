class UsersProjectsController < ApplicationController
	def index
        @user = User.find(params[:user_id])
		@projects = @user.projects.order("updated_at DESC").all
        @users_projects = UsersProject.where(:user_id => @user.id)
        @as_owner = Project.where(:creator_id => @user.id).all
        @as_member = @users_projects.where(:access => 1).all
        @as_watcher = @users_projects.where(:access => 2).all
	end

	def show
		@project = Project.find(params[:id])
		@owner = User.find(@project.creator_id)
        @activities = @project.activities.order("updated_at DESC").all
	end

end
