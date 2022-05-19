# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 50 }

  belongs_to :category
  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
