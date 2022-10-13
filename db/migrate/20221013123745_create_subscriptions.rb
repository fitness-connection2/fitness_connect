class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :member_id, null: false
      t.integer :trainer_id, null: false
      t.timestamps
    end
  end
end
