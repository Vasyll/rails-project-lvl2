# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :nullify, foreign_key: 'creator_id', inverse_of: :creator
  has_many :post_comments, dependent: :nullify
  has_many :post_likes, dependent: :nullify
end
