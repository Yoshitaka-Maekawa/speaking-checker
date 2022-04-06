class Question < ApplicationRecord
  include ActiveModel::Validations

  enum phase: { original: 0, one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10}
  has_many :recording_results
  validates :english_text, presence: true
  validates :phase, presence: true
  validates_with InputValidator
end
