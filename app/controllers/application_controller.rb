class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
	  def current_user
	  	if session[:user_id]
		    @current_user ||= User.find(session[:user_id])
		else
			@current_user = nil
		end
	  end
	  def signed_in_user
	  	if current_user.nil?
	  		redirect_to root_url
	  	end
	  end
	  helper_method :current_user
	  helper_method :signed_in_user
  
end
