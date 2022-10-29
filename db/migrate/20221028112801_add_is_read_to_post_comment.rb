class AddIsReadToPostComment < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :is_read, :boolean, default: false, null: false
  end
end
