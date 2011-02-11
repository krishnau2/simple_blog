class UsersController < ApplicationController

  def index
    list_posts = Post.new
    @current_user      = session[:current_user]
    #collecting current logged in user posts.
    @current_user_post = list_posts.get_current_user_post(@current_user)
  end

end
