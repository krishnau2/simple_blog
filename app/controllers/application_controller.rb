class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :facebook.auth.getSession
  helper_method :facebook.session

#  def fetch_logged_in_user
#    if facebook.session
#      @current_user = User.find_by_fb_user(facebook_session.user)
#    else
#      return unless session[:user_id]
#      @current_user = User.find_by_id(session[:user_id])
#    end
#  end
end
