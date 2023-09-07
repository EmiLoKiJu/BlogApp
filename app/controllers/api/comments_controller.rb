class Api::CommentsController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    comments = post.comments

    render json: comments, status: :ok
  end

  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(text: params[:text], author: current_user)

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
