class Phrase < ApplicationRecord
  include PublicActivity::Model


  PHRASE_CATEGORY = [['Actions', 'Actions'], ['Time', 'Time'], ['Productivity', 'Productivity'], ['Apologies', 'Apologies'], ['Common', 'Common']]


  include SharedMethods
  extend FriendlyId

  belongs_to :user
  has_many :examples

  accepts_nested_attributes_for :examples

  acts_as_votable
  friendly_id :phrase, use: :slugged
  # tracked owner: Proc.new{ |controller, model| model.user }


  validates :phrase, :translation, presence: true

  enum category: { 'Actions': 0, 'Time': 1, 'Productivity': 2, 'Apologies': 3, 'Common': 4 }


end
