# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @attrs = {
      title: Faker::Book.title,
      body: Faker::Books::Dune.quote,
      category_id: categories(:one).id
    }
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should show post' do
    get post_url @post
    assert_response :success
  end

  test 'guest should raise error from new' do
    get new_post_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signin user should get new' do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test 'guest cant create post' do
    post posts_url, params: { post: @attrs }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signed user can create post' do
    sign_in @user

    post posts_url, params: { post: @attrs }
    assert_response :redirect

    blog_post = Post.find_by! title: @attrs[:title]
    assert { blog_post.creator == @user }

    assert_redirected_to post_url(blog_post)
  end
end
