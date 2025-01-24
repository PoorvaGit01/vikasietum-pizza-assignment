class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end


  def authorize_customer!
    redirect_to root_path, alert: "Access Denied!" unless current_user&.customer?
  end

  def authorize_vendor!
    redirect_to root_path, alert: "Access Denied!" unless current_user&.vendor?
  end

end
