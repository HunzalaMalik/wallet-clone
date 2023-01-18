# frozen_string_literal: true

RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.parent_controller = 'ApplicationController'
  config.authorize_with :cancancan
  config.current_user_method do
    current_user
  end

  config.actions do
    dashboard       
    index        
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
