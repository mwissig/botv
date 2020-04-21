class Item < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort
  belongs_to :playlist
  validates :video_id, presence: true
  validates :playlist_id, presence: true
  validates :sort, presence: true
end
