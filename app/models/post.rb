class Post < ApplicationRecord
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  belongs_to :member, optional: :true #ログインしていなくても投稿出来るようにする
  belongs_to :trainer, optional: :true #ログインしていなくても投稿出来るようにする
  validate :required_either_member_or_trainer

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def required_either_member_or_trainer
    # 演算子 ^ で排他的論理和（XOR）にしています
    # 会員かトレーナーのどちらかの値があれば true
    # 会員、トレーナーどちらも入力されている場合や入力されていない場合は false
    return if member_id.present? ^ trainer_id.present?

    errors.add(:base, '会員またはトレーナーのどちらか一方でログインしてください')
  end

  def self.search(keyword)
    unless keyword.blank?
      where('description LIKE ?', "%#{keyword}%")
    else
      all
    end
  end

  def liked_by_member?(member) #会員のいいね
    post_likes.exists?(member_id: member.id)
  end

  def liked_by_trainer?(trainer) #トレーナーのいいね
    post_likes.exists?(trainer_id: trainer.id)
  end

  def enable_post?
    # trainer_idがnilでなくて、trainerが有効である　または　member_idがnilでなくて、memberが有効である
    # 上記の条件を満たせば、レコードを返す
    unless (self.trainer_id.nil? == false && self.trainer.is_delete == false) || (self.member_id.nil? == false && self.member.is_delete == false)
      self
    end
  end
end
