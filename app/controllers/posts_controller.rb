class PostsController < ApplicationController

  # GET /posts
  # GET /posts.xml
  def index

    if logged_in?
      @page_title = "#{current_user.name}'s Posts"
      @posts = current_user.posts
    else
      @page_title = "WACS - Blog"
      @posts = Post.order("created_at DESC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
#    @show_edit_option = 0
#    The edit option is shown only if the post is viewed by the creator.
    unless session[:current_user_id] == ""
      @post_creator = Post.find(params[:id]).user_id
      @current_user_id = User.find_by_uid(session[:current_user_id]).id
      if @post_creator == @current_user_id
        @show_edit_option = 1
      end
    end
    @post = Post.find(params[:id])
    @page_title = "Post on #{@post.topic}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    if session[:login_status] == "loggedIn"
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml { render :xml => @post }
      end
    else
      redirect_to '/auth/facebook'
    end
  end

  # GET /posts/1/edit
  def edit
    post_creator = Post.find(params[:id]).user_id
    current_user_id = User.find_by_uid(session[:current_user_id]).id
    if  post_creator == current_user_id
      @post = Post.find(params[:id])
    else
      flash[:notice] = "You are not authorised to edit this post"
      redirect_to '/posts'
    end

  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])

    if @post.can_be_edited_by?(current_user)
      @post.destroy
    else
      flash[:notice] = "You are not authorised to delete this post"
      redirect_to :"/posts"
    end
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml { head :ok }
    end
  end
end
