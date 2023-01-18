# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pagy::Backend

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from CanCan::AccessDenied, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
    return rails_admin.dashboard_path if resource.has_role?(:admin)

    dashboard_index_path
  end

  def record_not_found
    flash[:alert] = 'Record Not Found!'
    redirection(current_user)
  end

  def user_not_authorized
    flash[:alert] = 'Sorry, You Are Not Authorized To Do This'
    redirection(current_user)
  end

  private

  def redirection(current_user)
    if current_user.has_role?(:admin)
      redirect_to rails_admin.dashboard_path
    elsif current_user.has_role?(:user)
      redirect_to main_app.dashboard_index_path
    else
      redirect_to main_app.root_path
    end
  end
end
