# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include SharedMethods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :phrases
  has_many :examples

  acts_as_voter

  validates :username, presence: true

  def new_activity?
    PublicActivity::Activity.where(recipient_id: id, readed: false).any?
  end

end
