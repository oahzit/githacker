class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
  	redirect_to root_path, :alert => exception.message
  end

  # Create helper method to determine user role: admin
  helper_method :admin?  

  protected

  def admin?
  	if current_user.present?
  		current_user.has_role? :admin
  	else
  		false
  	end
  end  

  # Create authorization function to prevent users from accessing other users content 
  def authorize
  	access = true
  	if !admin?
  		access = false
  		if params[:user_id].present?
  			@user = User.find(params[:user_id])
  			if @user == current_user
  				access = true
  			else 
  				access = false
  			end
  		elsif params[:project_id].present?
  			if UsersProject.where(:project_id => params[:project_id], :user_id => current_user.id).first.present? || Project.find(params[:project_id]).public
  				access = true
  			else 
  				access = false
  			end
  		end
  	end
  	
  	if !access
  		flash[:error] = "Unauthorized access"
  		redirect_to root_path
  		false
  	end
  end

end
