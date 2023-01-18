# frozen_string_literal: true

class WalletsController < ApplicationController
  load_and_authorize_resource
  before_action :set_wallet, only: %i[update]

  def new
    @wallet = current_user.build_wallet
  end

  def create
    @wallet = current_user.build_wallet(wallet_params)

    if @wallet.save
      flash[:notice] = 'Wallet was successfully created.'
    else
      flash[:error] = @wallet.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  def update
    if @wallet.update(wallet_params)
      flash[:notice] = 'Wallet was successfully updated.'
    else
      flash[:error] = @wallet.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  def wallet_params
    params.require(:wallet).permit(:amount, :user_id)
  end
end
