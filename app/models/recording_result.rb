class RecordingResult < ApplicationRecord
  include ConversionHelper
  belongs_to :question
  belongs_to :total_result
  belongs_to :rank
  validates :recognized_english, presence: true
  validates :average_score, presence: true
  validates :accuracy_score, presence: true
  validates :fluency_score, presence: true
  validates :completeness_score, presence: true

  def fetch_transcribed_parameter(object)
    object.reverse!.slice!(0, 9)
    object.reverse!
    object << "}"
    response = JSON.parse(object)

    self.recognized_english = response["Display"].end_with?(".", "?") ? response["Display"] : response["Display"] + "."
    self.average_score = response["PronunciationAssessment"]["PronScore"]
    self.accuracy_score = response["PronunciationAssessment"]["AccuracyScore"]
    self.fluency_score = response["PronunciationAssessment"]["FluencyScore"]
    self.completeness_score = response["PronunciationAssessment"]["CompletenessScore"]
  end

  def judge_rank(score)
    self.rank_id = Rank.where("(max_for_each >= ?) AND (min_for_each <= ?)", self.average_score, self.average_score).first.id
  end

  def change_integer_into_string(object)
    english_array = object.split.map do |string|
      next to_english(string.to_i) if (string.to_i != 0 || string == "0")
      next "divided by" if string == "/"
      string
    end

    fixed_english = english_array.join(" ")
    self.recognized_english = fixed_english.end_with?(".", "?") ? fixed_english : fixed_english + "."
  end
end
