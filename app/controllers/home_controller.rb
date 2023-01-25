# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :redirect_user, only: %i[index]

  def index; end

  private

  def redirect_user
    if current_user&.has_role?(:user)
      redirect_to dashboard_index_path
    elsif current_user&.has_role?(:admin)
      redirect_to rails_admin.dashboard_path
    end
  end
end
