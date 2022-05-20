# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  def create
    authenticate_user!
    @post = Post.find params[:post_id]
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @post
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
