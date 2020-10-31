class ApplicationController < ActionController::Base
	include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_order_items


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |profile_params|
      profile_params.permit(:username, :first_name, :last_name, :email, :displayname,
                         :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |profile_params|
      profile_params.permit(:username, :first_name, :last_name, :email, :displayname,
                         :password, :password_confirmation)
    end
  end


  private

  def set_order_items
    @order_items = current_ordering.order_items
  end



end
