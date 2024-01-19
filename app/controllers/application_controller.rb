class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

    private
    # Permits user name on top of authenticated email allowed by default on sign up
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
