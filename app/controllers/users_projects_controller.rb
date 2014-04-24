class UsersProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize

  def index
    @user = User.find(params[:user_id])
    @projects = @user.projects.order("updated_at DESC").all
    @users_projects = UsersProject.where(:user_id => @user.id)
    @as_owner = @users_projects.where(:access_level => 0).all
    @as_member = @users_projects.where(:access_level => 1).all
    @as_watcher = @users_projects.where(:access_level => 2).all
  end

  def show
    @user = User.find(params[:user_id])
    @users_project = UsersProject.find(params[:id])
    @project = Project.find(@users_project.project_id)
    @owner = Profile.find(@project.creator_id)
    @activities = @project.activities.order("updated_at DESC").all
  end

  def new
    @user = User.find(params[:user_id])
    @users_project = UsersProject.new
    @project = Project.new
  end

  def create
    @user = User.find(params[:user_id])

        # When a project is created 
        ActiveRecord::Base.transaction do
          @project = Project.create(params[:users_project][:project])

          if params[:group_id].present? 
            if params[:group_id] == "0"
        # if the group doesn't exist
        if params[:new_group] == ""
          @group = Group.create!(name: "#{@project.name} Team", owner_id: @user.id, parent_id: 0)

        else
          @name = params[:new_group]        
          @group = Group.create!(name: @name, owner_id: @user.id, parent_id: 0)
        end
      else
        # if the group exists
        @group = Group.find(params[:group_id])
      end
    end

        # a relationship to the group is automatically generated
        @projects_group = ProjectsGroup.create!(group_id: @group.id, project_id: @project.id)

        # and the user who created it is added to the group and project
        @users_group = UsersGroup.create!(user_id: @user.id, group_id: @group.id)
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

    def edit 
      @user = User.find(params[:user_id])
      @users_project = UsersProject.find(params[:id])
      @project = Project.find(@users_project.project_id)
    end

    def update
      @user = User.find(params[:user_id])
      @users_project = UsersProject.find(params[:id])
      @project = Project.find(@users_project.project_id)
      @project.update_attributes(params[:users_project][:project])
      
      respond_to do |format|
        if @project.save
          format.html { redirect_to user_users_project_path(@user, @users_project), notice: 'Project was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => 'edit', alert: 'Project was unsuccessfully updated.' }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
      end
    end 

    def destroy
      @user = User.find(params[:user_id])
      @users_project = UsersProject.find(params[:id])
      @project = Project.find(@users_project.project_id)
      if @user.profile.id == @project.creator_id
        @project.destroy
      end
      @users_project.destroy
      redirect_to :back
    end

    def add_member
        # When a project is created 
        @user = User.where(:email => params[:email]).first
        if !@user.present?
          @user = User.create!(:email => params[:email], :password => "password", :password_confirmation => "password")
        end
        @project = UsersProject.find(params[:id]).project
        @group = @project.master_group
        
        ActiveRecord::Base.transaction do
          @users_group = UsersGroup.create!(user_id: @user.id, group_id: @group.id, access_level: params[:users_project][:access_level])
          @users_project = UsersProject.create!(user_id: @user.id, project_id: @project.id, access_level: params[:users_project][:access_level])
        end

        respond_to do |format|
          if @users_project.save
               # leave a trail when project is created 
               @activity = Activity.new.add_member!(@user, @project)
               format.html { redirect_to :back, notice: 'Project was successfully created.' }
               format.json { head :no_content }
             else
              format.html { render :action => 'new', alert: 'Project was unsuccessfully created.' }
              format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
          end
        end


        def team
          @user = User.find(params[:user_id])
          @users_project = UsersProject.find(params[:id])
          @project = Project.find(@users_project.project_id)
          @group = @project.master_group
          @members = @project.master_group.members

          @owner = User.find(@project.creator_id)
        end

        def follow
          if !UsersProject.where(:user_id => params[:user_id], :project_id => params[:project_id]).present?
            @users_project = UsersProject.create!(:user_id => params[:user_id], :project_id => params[:project_id], :access_level => 2)
          end
          redirect_to :back
        end

      end