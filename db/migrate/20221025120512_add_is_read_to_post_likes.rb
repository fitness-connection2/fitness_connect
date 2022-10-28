class AddIsReadToPostLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :post_likes, :is_read, :boolean, default: false, null: false
  end
end
