# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find params[:id]

    @comment = @post.comments.build
  end

  def new
    authenticate_user!
    @post = current_user.posts.build
    @categories = Category.all
  end

  def create
    authenticate_user!
    @post = current_user.posts.build(post_params)
    @categories = Category.all

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, notice: t('.failure')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
