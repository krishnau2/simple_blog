class AuthenticationsController < ApplicationController
  def index
    @page_title = "User's List"
    @users      = User.all
  end

  def create
    facebook_result           = request.env["omniauth.auth"]

    uid = facebook_result['uid']

    user = User.find_by_uid(uid)
    if user
      flash[:notice]                  = "#{user.name} signed in successfully!"
    else
      user = User.create(:name => facebook_result['user_info']['name'],
                         :category => "general",
                         :provider => facebook_result['provider'],
                         :uid => uid)
      flash[:notice]                  = "New user #{user.name} signed up and signed in successfully!"
    end

    session[:current_user]    = user.id
    redirect_to "/posts"
  end

  def logout
    session[:current_user]          = ""
    redirect_to "/home"
  end

end
