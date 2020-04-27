class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :status, dependent: :destroy
  has_many :videos, dependent: :destroy
    has_many :playlists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bulbs, dependent: :destroy
    has_many :flags, dependent: :destroy
  has_one :permission, dependent: :destroy
      has_many :notifications, dependent: :destroy
after_create :make_permission

private

def make_permission
  @permission = Permission.create(
    user_id: self.id,
    is_horny: false,
    can_post_video: true,
    can_bulb: true,
    can_comment: true
  )
  @permission.save!
end
end
