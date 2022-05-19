# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  def create
    @post = Post.find params[:post_id]
    @like = @post.likes.build
    @like.user_id = current_user.id

    Rails.logger.debug @post.inspect
    Rails.logger.debug @like.inspect

    if @like.save
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find params[:post_id]
    Rails.logger.debug post.inspect
    Rails.logger.debug post.likes.inspect
    like = post.likes.find params[:id]

    if like.destroy
      redirect_to post
    else
      redirect_to post, status: :unprocessable_entity
    end
  end
end
