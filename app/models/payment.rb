class Payment < ApplicationRecord
  has_many :subscription
end
