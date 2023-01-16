# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  protected

  def after_sign_in_path_for(resource)
    return rails_admin.dashboard_path if resource.has_role?(:admin)
    dashboard_index_path
  end


  def record_not_found
    flash[:notice] = "Record Not Found!"
    redirect_to(request.referer || root_path)
  end
end
