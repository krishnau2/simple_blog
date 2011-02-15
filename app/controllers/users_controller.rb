class UsersController < ApplicationController

  def index
    list_posts = Post.new
    @user_name = User.new
    @current_user      = session[:current_user]
    @current_user_id = User.find_by_name(@current_user)
    #collecting current logged in user posts.
    @current_user_post = list_posts.get_current_user_post(@current_user_id)

  end

end
