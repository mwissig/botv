class ApplicationController < ActionController::Base
   before_action :authenticate_user!
      before_action :update_permission
before_action :define_categories
before_action :define_flagreasons

   # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
protect_from_forgery prepend: true, with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
          devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
      end

private

def update_permission

  if user_signed_in?

    if current_user.permission == nil
      @permission = Permission.new(
        user_id: current_user.id
      )
      @permission.save!
    else

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

def define_categories
@categories = [
  "ASMR",
  "Accidents & Explosions",
  "Advertisements",
  "Animals",
  "Animation",
  "Arts",
  "Business",
  "Clips",
  "Crime",
  "Dance",
  "Dashcam",
  "Economics",
  "Educational",
  "Fashion",
  "Food",
  "Full-length",
  "Health",
  "Horror",
  "Humor",
  "I Made This",
  "Memes",
  "Military",
  "Movies",
  "Music",
  "Music Video",
  "Nerds",
  "NSFW",
  "News & Politics",
  "Performance",
  "Religion",
  "Science & Tech",
  "Short Films",
  "Sports",
  "Stunts",
  "TV",
  "Toys & Games",
  "Trailers",
  "Video Games"
]
end

def define_flagreasons
  @flagreasonsvideo = [
    "Bad video URL",
    "NSFW and not marked",
    "Bug/formatting error",
    "Doxxing",
    "Threats/illegal content",
    "Banned user alt account",
    "Spam",
    "Other"
  ]
  @flagreasons = [
    "Bug/formatting error",
    "Doxxing",
    "Threats/illegal content",
    "Banned user alt account",
    "Spam",
    "Other"
  ]
  @flag = Flag.new
end

end
