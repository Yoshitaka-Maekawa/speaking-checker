class Rank < ApplicationRecord
  has_many :recordin_results
  has_many :total_results
end
