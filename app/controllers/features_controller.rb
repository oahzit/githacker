class FeaturesController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    if params[:project_id].present?
    	@project = Project.find(params[:project_id])
    end
  end
end
