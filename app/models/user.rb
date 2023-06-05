# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :user_icon
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
