# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    puts @posts.inspect
  end

  def show
    @post = Post.find params[:id]

    @comment = @post.comments.build
  end

  def new
    authenticate_user!
    @post = current_user.posts.build
    @categories = PostCategory.all
  end

  def create
    authenticate_user!
    @post = current_user.posts.build(post_params)
    @categories = PostCategory.all

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
