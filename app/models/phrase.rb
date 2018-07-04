class Phrase < ApplicationRecord
  PHRASE_CATEGORY = [['Actions', 'Actions'], ['Time', 'Time'], ['Productivity', 'Productivity'], ['Apologies', 'Apologies'], ['Common', 'Common']]


  include SharedMethods
  extend FriendlyId
  friendly_id :phrase, use: :slugged

  belongs_to :user
  has_many :examples

  accepts_nested_attributes_for :examples

  acts_as_votable
  def score
    self.get_likes.size - self.get_downvotes.size
  end

  validates :phrase, :translation, presence: true

  enum category: { 'Actions': 0, 'Time': 1, 'Productivity': 2, 'Apologies': 3, 'Common': 4 }


end
