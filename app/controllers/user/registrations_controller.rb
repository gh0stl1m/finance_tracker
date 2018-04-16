class User::RegistrationsController < Devise::RegistrationsController
  before_action :configurePermittedParameters
  
  protected
  def configurePermittedParameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

end