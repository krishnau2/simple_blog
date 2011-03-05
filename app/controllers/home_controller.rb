class HomeController < ApplicationController
  def index
    @page_title = "WACS-Home"
    @post       = Post.order("updated_at DESC").limit(5)
  end
end
