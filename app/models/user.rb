# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum :gender, { male: 0, female: 1, cant_specify: 2 }

  validates :email, presence: true
  validates :name, presence: true, allow_blank: false,
                   format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
  validates :gender, inclusion: { in: User.genders.keys }
  validates :password, length: { maximum: 8 }
  validates :cnic, presence: true, length: { maximum: 13 }
  validates :address, presence: true
end
