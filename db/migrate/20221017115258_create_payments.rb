class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string "payment_method", null: false
      t.timestamps
    end
  end
end
