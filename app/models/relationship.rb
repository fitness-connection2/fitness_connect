class Relationship < ApplicationRecord
  has_one :notification, as: :subject, dependent: :destroy
  scope :new_relationships, -> { where(is_read: false) } #複数のクエリをまとめる。未読のサブスク登録を呼ぶメソッド。
end
