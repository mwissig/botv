class Video < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :parent, dependent: :destroy
  has_many :bulbs, as: :bulbable, dependent: :destroy
    validates :user_id, presence: true
  validates :id_code, presence: true
  validates :provider, presence: true
  validates :title, presence: true, length: {maximum: 255}
  validates :category1, presence: true
  validates :embed_url, presence: true
  validates :embed_code, presence: true
  before_save :default_values

def default_values
  self.user_id ||= current_user.id
end

end
