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
      flash[:notice]                  = "#{@name} signed in successfully!"
    else
      user = User.create(:name => facebook_result['user_info']['name'],
                         :category => "general",
                         :provider => facebook_result['provider'],
                         :uid => uid)
      flash[:notice]                  = "New user #{@name} signed up and signed in successfully!"
    end

    session[:current_user]    = user
    redirect_to "/posts"
  end

  def logout
    session[:current_user]          = ""
    session[:current_user_id]       = ""
    session[:login_status]          = "loggedOut"
    session[:current_user_category] = ""
    redirect_to "/home"
  end

  def edit

  end

#  def show
#    respond_to do |format|
#      format.html # index.html.erb
#    end
#  end

end
