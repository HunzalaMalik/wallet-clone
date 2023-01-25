# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, User

    if user.has_role? :user
      user_abilities(user)
    elsif user.has_role? :admin
      admin_abilities
    end
  end

  def admin_abilities
    can :manage, :all
    can :access, :rails_admin
    can :manage, :dashboard
    cannot :index, FriendshipsController
    cannot :new, FriendshipsController
    cannot :index, FundTransactionsController
    cannot :new, FundTransactionsController
    cannot :index, DashboardController
    cannot :show, UsersController
    cannot :edit, Users::RegistrationsController
  end

  def user_abilities(user)
    can %i[read update], User, user: user
    can :manage, Friendship, user: user
    can %i[read create], FundTransaction, user: user
    can :index, FriendshipsController
    can :new, FriendshipsController
    can :index, FundTransactionsController
    can :new, FundTransactionsController
    can :index, DashboardController
    can :show, UsersController, user: user
    can :edit, Users::RegistrationsController
  end
end
