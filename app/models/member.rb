class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_TYPE = {"Trainer": 0, "Member": 1}
  HOGE = "HOGE"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_one :subscription, dependent: :destroy #サブスクは1つのみ登録可能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id" #同じモデル名でややこしいので、名前だけ変更
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id" #同じモデル名でややこしいので、名前だけ変更
  #has_many :followings, through: :relationships, source: :followed #フォロー・フォロワーの表示するためRelationshipモデルから参照
  #has_many :followers, through: :reverse_of_relationships, source: :follower
  has_one_attached :profile_image

  validates :name, presence: true
  validates :user_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :telephone_number, presence: true

  def new_liked
    PostLike.new_likes.joins(:post).distinct.where('post.member_id': self.id)
  end

  def new_commented
    PostComment.new_comments.joins(:post).distinct.where('post.member_id': self.id)
  end

  def new_followed
    Relationship.new_relationships.where('followed_id': self.id)
  end

  def get_profile_image(width, height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user_id, target)
    Relationship.create(followed_type: target, followed_id: user_id, follower_id: self.id, follower_type: USER_TYPE[:"#{self.class.name}"])
  end

  def unfollow(user_id, target) #そのユーザーがフォローを外すときのメソッド
    relationship =  Relationship.find_by(followed_type: target, followed_id: user_id, follower_id: self.id, follower_type: USER_TYPE[:"#{self.class.name}"])
    relationship.destroy
  end

  def following?(user, target) #そのユーザーがフォローしているか判定
    relationships.any? do |relationship|
      relationship.followed_id == user.id && relationship.followed_type == target
    end
  end

  def following_count
    get_following_members.count + get_following_trainers.count
  end

  def get_following_members
    Member.find(Relationship.where(follower_id: self.id, followed_type: USER_TYPE[:"Member"]).pluck('followed_id'))
  end

  def get_following_trainers
    Trainer.find(Relationship.where(follower_id: self.id, followed_type: USER_TYPE[:"Trainer"]).pluck('followed_id'))
  end
  
  def get_following_users
    get_following_members + get_following_trainers
  end

  def follower_count
    get_followed_members.count + get_followed_trainers.count
  end

  def get_followed_members
    Member.find(Relationship.where(followed_id: self.id, followed_type: USER_TYPE[:"Member"]).pluck('follower_id'))
  end

  def get_followed_trainers
    Trainer.find(Relationship.where(followed_id: self.id, followed_type: USER_TYPE[:"Trainer"]).pluck('follower_id'))
  end
  
  def get_followed_users
    get_followed_members + get_followed_trainers
  end

  # def get_follower_members #自分にフォローしている会員を取得。リレーションが使えないため、メソッドで定義。
  #   Member.find(Relationship.where(followed_id: self.id, follower_type: USER_TYPE[:"Member"]).pluck('follower_id'))
  # end

  def self.search(keyword)
    unless keyword.blank?
      where('user_name LIKE ?', "%#{keyword}%")
    else
      all
    end
  end

  # def get_follower_trainers #自分にフォローしているトレーナーを取得
  #   Trainer.find(Relationship.where(followed_id: self.id, follower_type: USER_TYPE[:"Trainer"]).pluck('follower_id'))
  # end

  # def get_followers
  #   [get_follower_trainers, get_follower_members]
  # end

end
