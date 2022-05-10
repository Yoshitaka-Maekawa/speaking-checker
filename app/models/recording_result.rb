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

  def judge_rank
    self.rank_id = Rank.where("(max_for_each >= ?) AND (min_for_each <= ?)", self.average_score, self.average_score).first.id
    self.start_time = Time.current
  end

  def judge_question_id
    if self.recognized_english == Question.find_by(english_text: self.recognized_english)&.english_text
      self.question_id = Question.find_by(english_text: self.recognized_english)&.id
    elsif ( self.question_id.blank? && self.recognized_english.match?(/[0-9%]/) )
      change_integer_into_string(self.recognized_english)
      self.question_id = Question.find_by(english_text: self.recognized_english)&.id
    end
  end

  def judge_sound(question_phase)
    if question_phase == "original"
      case
      when self.average_score >= 90.00
        'https://soundeffect-lab.info/sound/button/mp3/decision5.mp3'
      when self.average_score >= 80.00
        'https://soundeffect-lab.info/sound/anime/mp3/stupid4.mp3'
      else
        'https://soundeffect-lab.info/sound/anime/mp3/shock2.mp3'
      end
    else
      self.average_score >= 90.00 ? 'https://soundeffect-lab.info/sound/button/mp3/decision5.mp3' : 'https://soundeffect-lab.info/sound/anime/mp3/shock2.mp3'
    end
  end

  def change_integer_into_string(object)
    english_array = object.split.map do |string|
      next string if (string.to_i != 0 && string.include?("/"))
      next to_english(string.to_i) if (string.to_i != 0 || string == "0")
      next "divided by" if string == "/"
      string
    end

    fixed_english = english_array.join(" ")
    self.recognized_english = fixed_english.end_with?(".", "?") ? fixed_english : fixed_english + "."
  end
end
