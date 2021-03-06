class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :parent, polymorphic: true
  has_many :comments, as: :parent, dependent: :destroy
  has_many :bulbs, as: :bulbable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy
  validates :user_id, presence: true
  validates :parent_id, presence: true
  validates :body, presence: true
  validates :parent_type, presence: true
  def default_values
    self.user_id ||= current_user.id
  end
end
