# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(_resource)
    dashboard_index_path if current_user.has_role? :user
    rails_admin.dashboard_path if current_user.has_role? :admin
  end
end
