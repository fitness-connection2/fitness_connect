class SubscriptionPlan < ApplicationRecord
  has_many :subscription
  has_one :notification, as: :subject, dependent: :destory
end
