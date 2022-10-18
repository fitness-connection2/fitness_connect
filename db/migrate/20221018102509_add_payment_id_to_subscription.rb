class AddPaymentIdToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :payment_id, :integer
  end
end
