class PostsController < ApplicationController

  before_action :require_logged_in, only: [:destroy, :edit, :update, :create, :new]

  def index
    redirect_to subs_url
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      debugger
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end

  end

  def edit
    @post = current_user.posts.find(params[:id])
    if @post
      render :edit
    else
      flash.now[:errors] = ["Post failed to post"]
      redirect_to subs_url
    end
  end

  def update
  end

  def new
    @post = Post.new
    render :new
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
