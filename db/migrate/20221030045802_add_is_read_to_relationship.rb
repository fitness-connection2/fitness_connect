class AddIsReadToRelationship < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :is_read, :boolean, default: false, null: false
  end
end
