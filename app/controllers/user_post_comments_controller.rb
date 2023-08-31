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
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully.'
    else
      # puts @comment.errors.full_messages
      redirect_to new_user_post_comment_path(@user, @post), alert: 'There was an error creating the comment.'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy
    redirect_to user_post_path(@comment.post.author, @comment.post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
