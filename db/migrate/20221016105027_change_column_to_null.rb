class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :subscription_plans, :payment_method, true
    change_column_null :subscription_plans, :period, true
  end

  def down
    change_column_null :subscription_plans, :payment_method, false
    change_column_null :subscription_plans, :period, false
  end
end
