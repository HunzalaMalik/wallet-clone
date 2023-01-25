# frozen_string_literal: true

class ErrorsController < ApplicationController
  def not_found
    render '404', status: :not_found, layout: false
  end

  def internal_server_error
    render '500', status: :not_found, layout: false
  end
end
