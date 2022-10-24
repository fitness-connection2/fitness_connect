class Subscription < ApplicationRecord
  belongs_to :member, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :trainer, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :subscription_plan
  belongs_to :payment
  has_one :notification, as: :subject, dependent: :destroy
  validate :required_either_member_or_trainer

  def required_either_member_or_trainer
    # 演算子 ^ で排他的論理和（XOR）にしています
    # 会員かトレーナーのどちらかの値があれば true
    # 会員、トレーナーどちらも入力されている場合や入力されていない場合は false
    return if member_id.present? ^ trainer_id.present?
  end

  def subtotal
    (subscription_plan.price * period)
  end
end
