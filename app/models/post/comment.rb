# frozen_string_literal: true

class Post::Comment < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :post

  has_ancestry

  validates :content, presence: true
end
