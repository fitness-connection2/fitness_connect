class AddIsReadToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :is_read, :boolean, default: false, null: false
  end
end
