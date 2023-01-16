# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :create, User

    # return if user.blank?

    # can %i[read update], User, user: user

    # return unless user.admin?

    # can %i[read update destroy], User
  end
end
