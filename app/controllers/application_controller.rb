class ApplicationController < ActionController::Base
   before_action :authenticate_user!
      before_action :update_permission
   @users = User.all
   # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
          devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
      end

before_action :set_raven_context

private

def set_raven_context
  Raven.user_context(id: session[:current_user_id]) # or anything else in session
  Raven.extra_context(params: params.to_unsafe_h, url: request.url)
end

def update_permission

  if user_signed_in?

    if current_user.permission == nil
      @permission = Permission.new(
        user_id: current_user.id
      )
      @permission.save!
    end
if current_user.permission.video_ban_end != nil
    if current_user.permission.video_ban_end < DateTime.now
      current_user.permission.video_ban_end = nil
      current_user.permission.can_post_video = true
      current_user.permission.save!
    end
  end

if current_user.permission.comment_ban_end != nil
    if current_user.permission.comment_ban_end < DateTime.now
      current_user.permission.comment_ban_end = nil
      current_user.permission.can_comment = true
      current_user.permission.save!
    end
  end

if current_user.permission.bulb_ban_end != nil
    if current_user.permission.bulb_ban_end < DateTime.now
      current_user.permission.bulb_ban_end = nil
      current_user.permission.can_bulb = true
      current_user.permission.save!
    end
  end

  end
end

end
