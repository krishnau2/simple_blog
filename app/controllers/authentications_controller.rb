class AuthenticationsController < ApplicationController
  def index
    @page_title = "User's List"
    @users = User.all
  end

  def create
    auth          = request.env["omniauth.auth"]
    @name         = auth['user_info']['name']
    @uid          = auth['uid']
    provider      = auth['provider']

    existing_user = User.find_by_uid(@uid)
    if existing_user
      flash[:notice] = "Old user #{@name} Signed in Successfully"
      redirect_to "/posts"
    else
      new_user       = User.create(:name => @name, :category => "general", :provider => provider, :uid => @uid)
      flash[:notice] = "New user #{@name} Signed in Successfully"
      redirect_to "/posts"
    end

  end

  def destroy
  end

  def edit
    
  end

end
