class ApplicationController < ActionController::Base
	include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_location, unless: :devise_controller?
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


  def after_sign_in_path_for(resource)
    previous_path = session[:previous_url]
    session[:previous_url] = nil
    previous_path || root_path
  end


  private

  def set_order_items
    @order_items = current_ordering.order_items
  end

  def store_location
    if(request.path != "/profiles/sign_in" &&
        request.path != "/profiles/sign_up" &&
        request.path != "/profiles/password/new" &&
        request.path != "/profiles/password/edit" &&
        request.path != "/profiles/confirmation" &&
        request.path != "/uprofiles/sign_out" &&
        !request.xhr? && !current_profile) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end



end
