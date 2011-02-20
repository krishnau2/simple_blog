class UsersController < ApplicationController

  def index
    if session[:current_user_category] == "admin"
      @list_users = User.all
    else
      redirect_to ('/home', :notice => 'You are not authorized to view this page')
    end
  end

  def edit
    if session[:current_user_category] == "admin"
      @user = User.find(params[:id])
    else
      redirect_to ('/home', :notice => 'You are not authorized to view this page')
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to('/users', :notice => 'User was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if session[:current_user_category] == "admin"
      @user = User.find(params[:id])
      @user.destroy
    else
      redirect_to ('/home', :notice => 'You are not authorized to view this page')
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end
end
