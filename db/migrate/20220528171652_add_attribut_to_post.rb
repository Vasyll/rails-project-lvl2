class AddAttributToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_likes_count, :integer, default: 0
  end
end
