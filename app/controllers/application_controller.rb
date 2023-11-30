class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend

  def after_sign_in_path_for(resources)
    case resources.role
    when "admin"
      admin_users_path
    when "customer"
      customer_path
    when "delivery_partner"
      delivery_partner_path
    else
      root_path
    end
  end

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, documents: []])
  end
 
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
