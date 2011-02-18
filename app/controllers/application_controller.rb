class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    if session[:current_user_category] == "admin"
      return true
    else
      return false
    end
  end
end
