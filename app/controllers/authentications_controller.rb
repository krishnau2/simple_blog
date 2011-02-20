class AuthenticationsController < ApplicationController
  def index
    @page_title = "User's List"
    @users      = User.all
  end

  def create
#    collecting the authenticated user-details returned by  facebook.
    facebook_result           = request.env["omniauth.auth"]

    @name                     = facebook_result['user_info']['name']
    uid                       = facebook_result['uid']
    provider                  = facebook_result['provider']
#    storing loggedIn user details in session variables for logIn session management
    session[:current_user]    = @name
    session[:current_user_id] = uid

    existing_user             = User.find_by_uid(uid)
    if existing_user
      flash[:notice]                  = "Old user #{@name} Signed in Successfully"
#      Storing the loggedIn user category for identifying and managing  user-roles.
      session[:current_user_category] = existing_user.category
      redirect_to "/posts"
    else
#      For a new user the user_category will be general
      new_user                        = User.create(:name => @name, :category => "general", :provider => provider, :uid => uid)
      session[:current_user_category] = "general"
      flash[:notice]                  = "New user #{@name} Signed in Successfully"
      redirect_to "/posts"
    end

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
