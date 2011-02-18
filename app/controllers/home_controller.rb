class HomeController < ApplicationController
  def index
    @page_title = "WACS-Home"
    @post       = Post.order("updated_at DESC").limit(5)
    #    empty object for User model class. for calling the get_user_name(user_id) function in the view.
    @user_name  = User.new
  end
end
