class Phrase < ApplicationRecord
  PHRASE_CATEGORY = [['Actions', 'Actions'], ['Time', 'Time'], ['Productivity', 'Productivity'], ['Apologies', 'Apologies'], ['Common', 'Common']]

  belongs_to :user
  has_many :examples

  accepts_nested_attributes_for :examples

  extend FriendlyId
  friendly_id :phrase, use: :slugged


  validates :phrase, :translation, presence: true

  enum category: { 'Actions': 0, 'Time': 1, 'Productivity': 2, 'Apologies': 3, 'Common': 4 }

  def author?(user)
    self.user == user
  end

end
