class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    unless session[:current_user] == ""
      session[:login_status] = "loggedIn"
      current_user_name      = session[:current_user]
      @page_title            = "#{current_user_name}'s Posts"
      list_posts             = Post.new
      @current_user_id       = User.find_by_name(current_user_name)
      #collecting current logged in user posts.
      @posts                 = list_posts.get_current_user_post(@current_user_id)
    else
      session[:login_status] = "loggedOut"
      @page_title            = "WACS - Blog"
      @posts                 = Post.order("created_at DESC")
    end

#    empty object for User model class. for calling the get_user_name(user_id) function in the view.
    @user_name = User.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post       = Post.find(params[:id])
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
    @post = Post.find(params[:id])
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
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml { head :ok }
    end
  end
end
