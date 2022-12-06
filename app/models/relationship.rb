class Relationship < ApplicationRecord

  enum follower_type: { trainer: 0, member: 1 }, _prefix: true
  enum followed_type: { trainer: 0, member: 1 }, _prefix: true

  scope :new_relationships, -> { where(is_read: false) } #複数のクエリをまとめる。未読のサブスク登録を呼ぶメソッド。
end
