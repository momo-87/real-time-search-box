class QueryAnalytic < ApplicationRecord
  validates :query, presence: true, length: { maximum: 250 }
  validates :ip_address, presence: true
  validates :complete, presence: true
end
