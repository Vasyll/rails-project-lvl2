# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).eager_load(:creator).page(params[:page])
  end

  def show
    @post = Post.find params[:id]
    @like = @post.likes.find_by user_id: current_user&.id
    @comment = @post.comments.build
    @comments = @post.comments.arrange
  end

  def new
    authenticate_user!
    @post = current_user.posts.build
  end

  def create
    authenticate_user!
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
