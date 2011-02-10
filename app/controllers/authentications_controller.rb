class AuthenticationsController < ApplicationController
  def index
  end

  def create
    omniauth      = request.env["omniauth.auth"]
    @name         = omniauth['user_info']['name']
    @uid          = omniauth['uid']
    provider      = omniauth['provider']

    existing_user = User.find_by_uid(@uid)
    if existing_user
      flash[:notice] = "Old user #{@name} Signed in Successfully"
      redirect_to "/posts"
    else
      new_user       = User.create(:name => @name, :category => "general", :provider => provider, :uid => @uid)
      flash[:notice] = "New user #{@name} Signed in Successfully"
      redirect_to "/posts"
    end
    #    if @authentication
    #      flash[:notice] = "Signed in Successfully."
    #      sign_in_and_redirect(:user, authentication.user)
    #    else
    #      @current_user = Authentication.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
    #      flash[:notice] = "Authentication successful."
    #      redirect_to authentications_url
    #    end

  end

  def destroy
  end

end
