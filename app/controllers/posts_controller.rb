class PostsController < ApplicationController
  before_action :authenticate_user!



  def index
    @posts = Post.all.reverse
    @posts_count = current_user.posts.length
  end

  def new

  end

  def create
    new_post = Post.new(user_id: current_user.id, content:params[:content])
    if new_post.save
      redirect_to '/'
    else
      redirect_to 'posts/new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find_by(id:params[:id])
    unless @post.user_id==current_user.id
      redirect_to '/'
    else
    @post.content = params[:content]
    @post.save
    redirect_to '/'
    end
  end
  def destroy
    @post = Post.find_by(id:params[:id])
    unless @post.user_id == current_user.id
      redirect_to '/'
    else
      @post.destroy
      redirect_to '/'
    end
  end

  def likepeople
    @post = Post.find_by(id:params[:id])
    @username=@post.user.name.all
  end
end
