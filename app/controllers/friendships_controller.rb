# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[edit update destroy]
  before_action :create_friendship, only: %i[create]

  def index
    @pagy, @friendships = pagy(current_user.friendships.all.order('created_at DESC'), items: 7)
  end

  def new
    @friendship = current_user.friendships.build
  end

  def create
    if @friendship.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend('payees', partial: 'friendships/friendship',
                                                              locals: { friendship: @friendship })
        end
      end
    else
      flash[:error] = @friendship.errors.full_messages.to_sentence
      redirect_to request.referer
    end
  end

  def edit; end

  def update
    if @friendship.update(friendship_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('payees', partial: 'friendships/friendship',
                                                              locals: { friendship: @friendship })
        end
      end
    else
      flash[:error] = @friendship.errors.full_messages.to_sentence
      redirect_to request.referer
    end
  end

  def destroy
    @friendship.destroy

    redirect_to request.referer, success: 'Payee has been removed'
  end

  private

  def create_friendship
    params[:friendship][:friend_id] = User.find_payee(params[:friendship][:payee_info]).last.id

    @friendship = current_user.friendships.build(friendship_params)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id, :nickname)
  end
end
