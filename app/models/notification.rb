class Notification < ApplicationRecord
  belongs_to :member, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :trainer, optional: :true #ログインしていなくても投稿出来るようにする

  enum action_type: {
    liked_the_post_member_to_trainer: 0,
    liked_the_post_trainer_to_member: 1,
    followed_member: 2,
    followed_trainer: 3,
    commented_on_the_post_member_to_trainer: 4,
    commented_on_the_post_trainer_to_member: 5,
    subscribed_trainer: 6,
    subscribed_member: 7
  }
end
