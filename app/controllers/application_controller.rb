class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

private
  def current_user
    session[:current_user]
  end

  def logged_in?
    not current_user.blank?
  end

end
