# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]

    validates :name, presence: true
    validates :email, presence: true
  end

  def name_or_email
    name.presence || email
  end
end
