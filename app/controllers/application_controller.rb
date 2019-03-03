class ApplicationController < ActionController::Base

  # Lets Ruby know that these are helper methods so they can be used outside of controllers
  helper_method :current_user, :logged_in?
  
  def current_user
    # debugger
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in? 
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
