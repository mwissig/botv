class Status < ApplicationRecord
  belongs_to :user
  validates :brief, length: { maximum: 120 }
    validates :rating, presence: true
end
