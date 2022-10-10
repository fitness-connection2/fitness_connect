class AddColumnsToRelationship < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :follower_type, :integer, null: false
    add_column :relationships, :followed_type, :integer, null: false
  end
end
