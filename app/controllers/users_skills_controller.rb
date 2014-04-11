class UsersSkillsController < ApplicationController
	def index
		@user = User.find(params[:user_id])
		@projects = @user.projects.order("updated_at DESC").all
		@users_projects = UsersProject.where(:user_id => @user.id)
		@as_owner = Project.where(:creator_id => @user.id).all
		@as_member = @users_projects.where(:access => 1).all
		@as_watcher = @users_projects.where(:access => 2).all
	end

	def create
		@user = current_user
		Skill.all.each do |skill|
			if params["skill#{skill.id}"].present?
				UsersSkill.create!(:user_id => @user.id, :skill_id => params["skill#{skill.id}"])
			end
		end

		respond_to do |format|
			format.html { redirect_to :back, notice: 'Project was successfully created.' }
			format.json { head :no_content }
		end
	end

end
