# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[update destroy]

  def index
    @friendships = current_user.friendship.all
  end

  def create
    @friendship = current_user.friendship.build(friendship_params)

    if @friendship.save
      flash[:notice] = 'Payee has been added successfully'
    else
      flash[:error] = @friendship.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  def update
    if @friendship.update(friendship_params)
      flash[:notice] = 'Payee was successfully updated.'
    else
      flash[:error] = @friendship.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  def destroy
    @friendship.destroy

    redirect_to request.referer, flash[:notice] = 'Payee has been removed'
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id, :nickname)
  end
end
