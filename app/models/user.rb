# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  has_one :wallet, dependent: :destroy
  has_one_attached :profile_pic, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :fund_transactions, dependent: :destroy

  enum :gender, { male: 0, female: 1, cant_specify: 2 }

  validates :name, presence: true, allow_blank: false,
                   format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
  validates :gender, inclusion: { in: User.genders.keys }
  validates :password, length: { maximum: 8 }
  validates :cnic, presence: true, length: { is: 13 }, uniqueness: true, numericality: { only_integer: true }
  validates :address, presence: true
  validates :contact_no, presence: true, length: { is: 11 }
  validate :acceptable_image

  after_create :assign_user_role, :create_user_wallet

  def acceptable_image
    return unless profile_pic.attached?

    errors.add(:profile_pic, 'is too big') unless profile_pic.byte_size <= 2.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    errors.add(:profile_pic, 'must be a JPEG or PNG') unless acceptable_types.include?(profile_pic.content_type)
  end

  def assign_user_role
    add_role(:user)
  end

  def create_user_wallet
    create_wallet(amount: 0)
  end

  def self.find_payee(info)
    where(email: info).or(where(contact_no: info))
  end
end
