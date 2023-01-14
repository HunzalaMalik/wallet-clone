# frozen_string_literal: true

json.extract! wallet, :id, :amount, :user_id, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
