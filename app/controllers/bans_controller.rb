class BansController < ApplicationController
  def mod
    @users = User.all.order("name ASC").paginate(:page => params[:page], :per_page => 20)
    @users.each do |user|
      if user.permission == nil
        @permission = Permission.new(
          user_id: user.id
        )
        @permission.save!
      end
    end
  end

  def index
  end
end
