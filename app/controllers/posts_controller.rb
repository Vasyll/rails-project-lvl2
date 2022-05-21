# frozen_string_literal: true

class PostsController < ApplicationController
  def index
return
    @posts = Post.all
  end

  def show
return
    @post = Post.find params[:id]

    @comment = @post.comments.build
  end

  def new
return
    authenticate_user!
    @post = current_user.posts.build
    @categories = Category.all
  end

  def create
return
    authenticate_user!
    @post = current_user.posts.build(post_params)
    @categories = Category.all

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
