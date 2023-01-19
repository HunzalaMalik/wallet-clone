# frozen_string_literal: true

class FriendshipsController < ApplicationController
  load_and_authorize_resource
  before_action :set_friendship, only: %i[edit update destroy]
  before_action :create_friendship, only: %i[create]
  before_action :set_payee, only: %i[create]
  before_action :update_friend_id, only: %i[create]

  def index
    authorize! :index, FriendshipsController

    @pagy, @friendships = pagy(current_user.friendships.all.order('created_at DESC'), items: 7)
  end

  def new
    authorize! :new, FriendshipsController

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
    if @friendship.destroy
      flash[:success] = 'Payee has been removed'
    else
      flash[:error] = @friendship.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  private

  def update_friend_id
    raise ActiveRecord::RecordNotFound if @payee.blank?

    params[:friendship][:friend_id] = @payee.last.id
  end

  def set_payee
    @payee = User.find_payee(params[:friendship][:payee_info])
  end

  def create_friendship
    @friendship = current_user.friendships.build(friendship_params)
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id, :nickname)
  end
end
