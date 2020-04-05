class Video < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :parent
  validates :id_code, presence: true
  validates :provider, presence: true
  validates :title, presence: true
  validates :embed_url, presence: true
  validates :embed_code, presence: true
  before_save :default_values

def default_values
  self.user_id ||= current_user.id
  self.upbulbs ||= 0
  self.downbulbs ||= 0
end

end
