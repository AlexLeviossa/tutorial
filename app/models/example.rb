# frozen_string_literal: true

class Example < ApplicationRecord
  include SharedMethods
  include PublicActivity::Model

  belongs_to :user
  belongs_to :phrase

  validates :example, presence: true

  acts_as_votable
  # tracked owner: Proc.new{ |controller, model| model.user }
end
