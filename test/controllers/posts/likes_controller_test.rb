# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post_with_like = posts(:one)
    @post_without_like = posts(:two)
    @like = post_likes(:one)
    @user = users(:one)
  end

  test 'guest cant like post' do
    post post_likes_url @post_without_like
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signin user should like post' do
    sign_in @user

    post post_likes_url @post_without_like
    assert_redirected_to post_url(@post_without_like)

    post_like = PostLike.find_by post_id: @post_without_like.id
    assert { post_like.user_id == @user.id }
  end

  test 'guest cant dislike post' do
    delete post_like_url @post_with_like, @like
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signin user should dislike post' do
    sign_in @user

    delete post_like_url @post_with_like, @like
    assert_redirected_to post_url(@post_with_like)

    assert { !PostLike.find_by(id: @like.id) }
  end
end
