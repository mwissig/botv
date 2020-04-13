class Permission < ApplicationRecord
  belongs_to :user
  before_save :default_values

   protected
  def default_values
    self.is_horny ||= false
    self.can_comment ||=true
    self.can_post_video ||= true
    self.can_bulb ||= true
  end
end
