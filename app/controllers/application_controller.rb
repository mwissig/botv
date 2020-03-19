class ApplicationController < ActionController::Base
   before_action :authenticate_user!
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

end
