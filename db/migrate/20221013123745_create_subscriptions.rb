class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :member_id
      t.integer :trainer_id
      t.integer :subscription_plan_id
      t.timestamps
    end
  end
end
