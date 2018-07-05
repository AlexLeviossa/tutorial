class Example < ApplicationRecord
  include SharedMethods

  belongs_to :user
  belongs_to :phrase

  validates :example, presence: true

  acts_as_votable

end
