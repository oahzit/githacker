class UsersGroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups.order("updated_at DESC").all
    @users_groups = UsersGroup.where(:user_id => @user.id)
  end

  def show
    @user = User.find(params[:user_id])
    @users_group = UsersGroup.find(params[:id])
    @group = Group.find(@users_group.group_id)
  end

  def new
    @user = User.find(params[:user_id])
    @users_group = UsersGroup.new
    @group = Group.new
  end

  def create
    @user = User.find(params[:user_id])

        respond_to do |format|
          if @group.save
          # leave a trail when project is created 
          @activity = Activity.new.create_message!(@user, @group)
          format.html { redirect_to user_users_groups_path(@user), notice: 'Group was successfully created.' }
          format.json { head :no_content }
        else
          format.html { render :action => 'new', alert: 'Group was unsuccessfully created.' }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
      end
  end

    def edit 
      @user = User.find(params[:user_id])
      @users_group = UsersGroup.find(params[:id])
      @group = Group.find(@users_group.project_id)
    end

    def update
      @user = User.find(params[:user_id])
      @users_group = UsersGroup.find(params[:id])
      @group = Group.find(@users_group.project_id)
      @group.update_attributes(params[:users_group][:project])
      
      respond_to do |format|
        if @group.save
          format.html { redirect_to user_users_group_path(@user, @users_group), notice: 'Group was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => 'edit', alert: 'Group was unsuccessfully updated.' }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
      end
    end 

    def destroy
      @user = User.find(params[:user_id])
      @users_group = UsersGroup.find(params[:id])
      @group = Group.find(@users_group.group_id)
      if @user.profile.id == @group.owner_id
        @group.destroy
      end
      @users_group.destroy
      redirect_to :back
    end

  end