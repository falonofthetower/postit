class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||=  User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    access_denied unless logged_in?
  end

  def admin?
    current_user.role == 'admin'
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def require_moderator
    access_denied unless logged_in? and current_user.moderator?
  end

  def access_denied
    flash[:error] = "You don't have the access to do that!"
    redirect_to root_path
  end
end
