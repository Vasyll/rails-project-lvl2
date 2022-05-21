# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  def create
return
    @post = Post.find params[:post_id]
    @like = @post.likes.build
    @like.user_id = current_user.id

    if @like.save
      redirect_to @post
    else
      redirect_to @post, status: :unprocessable_entity
    end
  end

  def destroy
return
    post = Post.find params[:post_id]
    like = post.likes.find params[:id]

    if like.destroy
      redirect_to post
    else
      redirect_to post, status: :unprocessable_entity
    end
  end
end
