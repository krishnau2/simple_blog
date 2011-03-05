class PostsController < ApplicationController

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

  def show
    @post = Post.find(params[:id])
    @editable = (@post.user_id == current_user.id) if logged_in?
    @page_title = "Post on #{@post.topic}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @post }
    end
  end

  def new
    if logged_in?
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml { render :xml => @post }
      end
    else
      redirect_to '/auth/facebook'
    end
  end

  def edit
    post = Post.find(params[:id])
    if  post.user_id == current_user.id
      @post = Post.find(params[:id])
    else
      flash[:notice] = "You are not authorised to edit this post"
      redirect_to '/posts'
    end

  end

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
