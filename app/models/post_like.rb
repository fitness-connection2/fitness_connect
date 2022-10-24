class PostLike < ApplicationRecord
  belongs_to :member, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :trainer, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :post
  has_one :notification, as: :subject, dependent: :destroy

  def required_either_member_or_trainer
    # 演算子 ^ で排他的論理和（XOR）にしています
    # 会員かトレーナーのどちらかの値があれば true
    # 会員、トレーナーどちらも入力されている場合や入力されていない場合は false
    return if member_id.present? ^ trainer_id.present?

    errors.add(:base, '会員またはトレーナーのどちらか一方でログインしてください')
  end
end
