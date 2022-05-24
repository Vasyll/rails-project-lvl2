# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @like = post_likes(:one)
    @user = users(:one)
  end

  test 'guest cant like post' do
    post post_likes_url @post
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signin user should like post' do
    sign_in @user

    post post_likes_url @post
    assert_redirected_to post_url(@post)

    post_like = PostLike.find_by post_id: @post.id
    assert { post_like.user_id == @user.id }
  end

  test 'guest cant dislike post' do
    delete post_like_url @post, @like
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signin user should dislike post' do
    sign_in @user
    delete post_like_url @post, @like
    assert_redirected_to post_url(@post)

    assert { !PostLike.exists? @like.id }
  end
end
