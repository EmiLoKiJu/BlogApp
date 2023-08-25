class UserPostLikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)
    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Like was successfully created.'
    else
      puts @comment.errors.full_messages
      redirect_to user_post_path(@user, @post), alert: 'There was an error creating the like.'
    end
  end
end