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
  	current_user.has_role? :admin
  end  

  # Create authorization function to prevent users from accessing other users content 
  def authorize
  	if !admin?
  		@user = User.find(params[:user_id])
  		if @user == current_user
  			true
  		else
  			flash[:error] = "Unauthorized access"
  			redirect_to root_path
  			false
  		end
  	end
  end

end
