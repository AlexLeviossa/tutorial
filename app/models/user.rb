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

  def increase_karma_phrase(count = 4)
    update_attribute(:karma, karma + count)
  end

  def decrease_karma_phrase(count = 2)
    update_attribute(:karma, karma - count)
  end

  def increase_karma_example(count = 2)
    update_attribute(:karma, karma + count)
  end

  def decrease_karma_example(count = 1)
    update_attribute(:karma, karma - count)
  end



  validates :username, presence: true



end
