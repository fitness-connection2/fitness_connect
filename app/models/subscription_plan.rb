class SubscriptionPlan < ApplicationRecord
  has_many :subscription
  validates :plan, presence: true
  validates :price, presence: true
end
