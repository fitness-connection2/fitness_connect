class Payment < ApplicationRecord
  has_many :subscription
  validates :payment_method, presence: true
end
