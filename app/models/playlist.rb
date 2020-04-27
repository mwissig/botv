class Playlist < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :comments, as: :parent, dependent: :destroy
  has_many :bulbs, as: :bulbable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy
  has_many :items, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 255}
  validates :category1, presence: true
  before_save :default_values

def default_values
  self.user_id ||= current_user.id
end
end
