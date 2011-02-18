class UsersController < ApplicationController

  def index
    @list_users = User.all
  end

  def edit

  end

  def destroy

  end
end
