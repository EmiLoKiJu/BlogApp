class UserPostCommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    puts 'hello'
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(author: current_user))
    puts @comment.errors.full_messages
    if @comment.save
      puts @comment.errors.full_messages
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      puts @comment.errors.full_messages
      redirect_to new_user_post_comment_path(@user, @post), alert: 'There was an error creating the comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end