class Example < ApplicationRecord
  belongs_to :user
  belongs_to :phrase

  validates :example, presence: true


end
