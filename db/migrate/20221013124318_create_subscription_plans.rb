class CreateSubscriptionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_plans do |t|
      t.string :plan, null: false
      t.integer :price, null: false
      t.integer :payment_method, null: false
      t.integer :period, null: false
      t.timestamps
    end
  end
end
