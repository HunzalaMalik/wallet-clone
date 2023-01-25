# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController  
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def edit
      authorize! :edit, Users::RegistrationsController

      super
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[email password password_confirmation name gender cnic address
                                                 contact_no])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[email password password_confirmation name gender cnic address
                                                 contact_no])
    end

    def after_update_path_for(_resource)
      dashboard_index_path
    end
  end
end
