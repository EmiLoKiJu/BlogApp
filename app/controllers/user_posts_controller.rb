class UserPostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts_per_page = 2
    @total_pages = (@user.posts.count.to_f / @posts_per_page).ceil
    @page = (params[:page] || 1).to_i
    offset = (@page - 1) * @posts_per_page
    @posts = @user.posts.limit(@posts_per_page).offset(offset)
    @users = User.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
