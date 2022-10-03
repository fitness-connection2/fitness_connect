class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|
      t.integer :member_id
      t.integer :trainer_id
      t.integer :post_id

      t.timestamps
    end
  end
end
