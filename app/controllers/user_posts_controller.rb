class UserPostsController < ApplicationController
  load_and_authorize_resource :post 

  def index
    @user = User.find(params[:user_id])
    @posts_per_page = 2
    @total_pages = (@user.posts.count.to_f / @posts_per_page).ceil
    @page = (params[:page] || 1).to_i
    offset = (@page - 1) * @posts_per_page
    @posts = @user.posts.limit(@posts_per_page).offset(offset)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @user = current_user
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params.merge(comments_counter: 0, likes_counter: 0))
    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully.'
    else
      redirect_to new_user_post_path(current_user), alert: 'There was an error creating the post.'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    authorize! :destroy, @post
    
    @post.comments.destroy_all
    @post.likes.destroy_all

    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
