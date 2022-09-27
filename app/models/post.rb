class Post < ApplicationRecord
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  belongs_to :member
  belongs_to :trainer

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
