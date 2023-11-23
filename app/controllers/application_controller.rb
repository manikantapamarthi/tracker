class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resources)
    case resources.role
    when "admin"
      admin_users_path
    when "customer"
      customer_path
    else
      root_path
    end
  end
end
