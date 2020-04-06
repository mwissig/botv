class Bulb < ApplicationRecord
  belongs_to :user
  belongs_to :bulbable, polymorphic: true
  def default_values
    self.user_id ||= current_user.id
  end
end
