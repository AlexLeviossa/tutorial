class Phrase < ApplicationRecord
  PHRASE_CATEGORY = [['Actions', 'Lable'], ['Time', 'Lable2'], ['Productivity', 'Lable3'], ['Apologies', 'Lable4'], ['Common', 'Lable5']]

  validates :phrase, :translation, presence: true

  enum category: { 'Lable': 0, 'Lable2': 1, 'Lable3': 2, 'Lable4': 3, 'Lable5': 4 }

end
