class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_one :subscription, dependent: :destroy #サブスクは1つのみ登録可能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id" #同じモデル名でややこしいので、名前だけ変更
  has_many :following_trainers, -> { follower_type_member.followed_type_trainer }, class_name: "Relationship", foreign_key: "follower_id"
  has_many :following_members, -> { follower_type_member.followed_type_member }, class_name: "Relationship", foreign_key: "follower_id"
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id" #同じモデル名でややこしいので、名前だけ変更
  has_many :followed_trainers, -> { followed_type_member.follower_type_trainer }, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followed_members, -> { followed_type_member.follower_type_member }, class_name: "Relationship", foreign_key: "followed_id"
  has_many :trainers, through: :member_trainers, dependent: :destroy
  has_many :member_trainers, dependent: :destroy
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

  def follow_trainer(trainer_id)
    Relationship.create(followed_id: trainer_id, follower_id: self.id, followed_type: :trainer, follower_type: :member)
  end

  def follow_member(member_id)
    Relationship.create(followed_id: member_id, follower_id: self.id, followed_type: :member, follower_type: :member)
  end

  def unfollow_trainer(trainer_id) #そのユーザーがフォローを外すときのメソッド
    relationship = Relationship.find_by(followed_id: trainer_id, follower_id: self.id, followed_type: :trainer, follower_type: :member)
    relationship.destroy
  end

  def unfollow_member(member_id) #そのユーザーがフォローを外すときのメソッド
    relationship = Relationship.find_by(followed_id: member_id, follower_id: self.id, followed_type: :member, follower_type: :member)
    relationship.destroy
  end

  def following?(user) #そのユーザーがフォローしているか判定
    if user.instance_of?(Member)
      following_members.where(followed_id: user.id).exists?
    elsif user.instance_of?(Trainer)
      following_trainers.where(followed_id: user.id).exists?
    end
  end


  # def follow_trainer
  #   member = current_member
  #   trainer = Trainer.find(params[:id]) #詳細ページでのみ有効
  #   MemberTrainer.create(member_id: member.id, trainer_id: trainer.id) #会員とトレーナーのidのみを取得してモデルに保存する
  # end


  # def unfollow_trainer
  #   member = current_member
  #   trainer = Trainer.find(params[:id]) #詳細ページでのみ有効
  #   member_trainer = MemberTrainer.find_by(member_id: member.id, trainer_id: trainer.id) #membertrainer内のカラムを取得
  #   member_trainer.destroy
  # end

  # def following_trainer? #フォローしてるかされていないかの判断
  #   member = current_member
  #   trainer = Trainer.find(params:[:id]) #詳細ページでのみ有効
  #   member_trainer = MemberTrainer.find_by(member_id: member.id, trainer_id: trainer.id)
  #   member_trainer.exists? #trueかfalseを返す
  # end


  def following_count
    following_members.count + following_trainers.count
  end

  def get_following_users
    members = Member.where(id: following_members.pluck(:followed_id))
    trainers = Trainer.where(id: following_trainers.pluck(:followed_id))
    members + trainers
  end

  def follower_count
    followed_members.count + followed_trainers.count
  end

  def get_followed_users
    members = Member.where(id: followed_members.pluck(:follower_id))
    trainers = Trainer.where(id: followed_trainers.pluck(:follower_id))
    members + trainers
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
