# frozen_string_literal: true
RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.parent_controller = 'ApplicationController'
  config.authorize_with :cancancan
  config.current_user_method do
    current_user
  end
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.actions do
    dashboard
    index
    new
    bulk_delete
    show
    edit
    delete
  end


  config.model 'Wallet' do
    list do
      include_fields :user, :amount, :created_at
    end
  end

  config.model 'FundTransaction' do

    edit do
      field :payee_info, :string do
        required true
        html_attributes do
          {:maxlength => 50}
         end
      end
      field :user_id, :hidden do
        def value
          bindings[:view]._current_user.id
        end
      end
      field :purpose_of_payment_id, :enum do
        enum do
          PurposeOfPayment.all.collect { |key| [key.name.humanize, key.id] }
        end
      end
      field :amount
    end
  end

end