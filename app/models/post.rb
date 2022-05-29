# frozen_string_literal: true

class Post < ApplicationRecord
  paginates_per 10

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 50 }

  belongs_to :category
  belongs_to :creator, class_name: 'User'
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy
end
