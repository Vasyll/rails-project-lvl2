# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    comment = post_comments(:one)
    @attrs = {
      content: 'Comment'
    }
    @nested_attrs = {
      content: 'Nested comment',
      parent_id: comment.id
    }
  end

  test 'guest cant create comment' do
    post post_comments_url(@post), params: { post_comment: @attrs }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'signed user can create comment' do
    sign_in @user

    post post_comments_url(@post), params: { post_comment: @attrs }
    assert_redirected_to post_url(@post)

    post_comment = PostComment.find_by content: @attrs[:content]
    assert { post_comment.parent.nil? }
  end

  test 'signed user can create nested comment' do
    sign_in @user

    post post_comments_url(@post), params: { post_comment: @nested_attrs }
    assert_redirected_to post_url(@post)

    post_comment = PostComment.find_by content: @nested_attrs[:content]
    assert { post_comment.parent.id == @nested_attrs[:parent_id] }
  end
end
