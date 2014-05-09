class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize

  def create_subteam
    @owner = current_user
    @parent = Group.find(params[:group][:parent_id])
    @project = Project.find(params[:project_id])
    ActiveRecord::Base.transaction do
      @group = Group.create!(:name => params[:group][:name], :parent_id => params[:group][:parent_id], :owner_id => @owner.id )
      @user = User.where(:email => params[:emails]).first
        if !@user.present?
          @user = User.create!(:email => params[:emails], :password => "password", :password_confirmation => "password")
        end
        if !UsersProject.where(:user_id => @user.id, :project_id => @project.id).first.present?
          @usersproject = UsersProject.create!(:access_level => params[:access_level], :user_id => @user.id, :project_id => @project.id) 
        end
      @usersgroup = UsersGroup.create!(:access_level => params[:access_level], :user_id => @user.id, :group_id => @group.id) 
      @master_usersgroup = UsersGroup.create!(:access_level => params[:access_level], :user_id => @user.id, :group_id => @parent.id) 
      @projectsgroup = ProjectsGroup.create!(:project_id => @project.id, :group_id => @group.id) 
    end
    redirect_to :back
  end

end

