# frozen_string_literal: true

class Post::Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
