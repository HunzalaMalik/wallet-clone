# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    flashes = {
      notice: 'bg-blue-100 border-l-4 border-blue-500 text-blue-700',
      success: 'bg-green-100 border-l-4 border-green-500 text-green-700',
      error: 'bg-red-100 border-l-4 border-red-500 text-red-700',
      alert: 'bg-orange-100 border-l-4 border-orange-500 text-orange-700'
    }
    flashes[level]
  end
end
