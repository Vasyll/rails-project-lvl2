# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Category.create(name: 'Ruby')
Category.create(name: 'JS')
Category.create(name: 'C++')

User.create(email: 'user@mail.ru', password: '123456', password_confirmation: '123456')

25.times do
  Post.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs.join("\n\n"),
    creator_id: 1,
    category_id: 1
  )
end
