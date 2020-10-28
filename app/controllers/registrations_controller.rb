class RegistrationsController < Devise::RegistrationsController
  protected

     #def new

         #@disable_full_footer_upfrica = true
      
     #end

  def after_inactive_sign_up_path_for(resource)
     'https://www.upfrica.com/thank-you'
  end
end
