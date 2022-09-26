class Post < ApplicationRecord
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  belongs_to :member, dependent: :destroy
  belongs_to :trainer, dependent: :destroy
end
