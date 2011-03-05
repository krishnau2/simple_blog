class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

private
  def current_user
    User.find(session[:current_user]) unless session[:current_user].blank?
  end

  def logged_in?
    not session[:current_user].blank?
  end

end
