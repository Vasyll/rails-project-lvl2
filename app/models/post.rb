class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :category
  belongs_to :creator, class_name: 'User'
end
