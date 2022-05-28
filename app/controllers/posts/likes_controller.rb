# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  def create
    authenticate_user!

    set_post_and_like

    if @like
      redirect_to @post
      return
    end

    like = @post.likes.build
    like.user_id = current_user.id

    if like.save
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def destroy
    authenticate_user!

    set_post_and_like

    if @like.nil?
      redirect_to @post
      return
    end

    if @like.destroy
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  private

  def set_post_and_like
    @post = Post.find params[:post_id]
    @like = @post.likes.find_by user_id: current_user.id
  end
end
