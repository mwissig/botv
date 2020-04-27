class Permission < ApplicationRecord
  belongs_to :user
  before_save :default_values
  before_update :save_state
  after_update_commit :send_notification

   protected
  def default_values
    self.is_horny ||= false
    self.can_comment ||=true
    self.can_post_video ||= true
    self.can_bulb ||= true
  end

def save_state
  @prevreason = self.reason_for_ban_was
end

  def send_notification
if self.can_comment == true
  @commenting = ""
else
  @commenting = "commenting,"
end
if self.can_bulb == true
  @bulbing = ""
else
  @bulbing = "bulbing,"
end
if self.can_post_video == true
  @posting_videos = ""
else
  @posting_videos = "posting videos,"
end
    if @prevreason != self.reason_for_ban && !self.reason_for_ban.blank?
    @notification = Notification.create(
        user_id: self.user_id,
        body: "You have had: #{@posting_videos} #{@commenting} #{@bulbing} ability suspended because: #{self.reason_for_ban}."
      )
      @notification.save!
    end
  end
end
