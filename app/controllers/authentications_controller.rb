class AuthenticationsController < ApplicationController
  def index
    @page_title = "User's List"
    @users      = User.all
  end

  def create
#    render :text => request.env["omniauth.auth"].to_yaml
    facebook_result = request.env["omniauth.auth"]

    @name = facebook_result['user_info']['name']
    uid = facebook_result['uid']
    provider = facebook_result['provider']
    session[:current_user] = @name
    session[:current_user_id] = uid
    existing_user          = User.find_by_uid(uid)
    if existing_user
      flash[:notice] = "Old user #{@name} Signed in Successfully"
      redirect_to "/posts"
    else
      new_user       = User.create(:name => @name, :category => "general", :provider => provider, :uid => uid)
      flash[:notice] = "New user #{@name} Signed in Successfully"
      redirect_to "/posts"
    end

  end

  def logout
    session[:current_user] = ""
    session[:login_status] = "loggedOut"
#    clear_facebook_session_information
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
