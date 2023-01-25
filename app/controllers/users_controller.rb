# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    authorize! :show, UsersController

    @user = User.find(params[:id])
  end
end
