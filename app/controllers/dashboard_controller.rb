# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    authorize! :index, DashboardController
  end
end
