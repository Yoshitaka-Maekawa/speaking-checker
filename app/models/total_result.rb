class TotalResult < ApplicationRecord
  belongs_to :rank
  belongs_to :user
  has_many :recording_results

  def judge_phase(phase: , score: )
    (phase == 10 && score >= 90) ? 10 : phase - 1
  end

  def judge_rank(phase)
    self.rank_id = Rank.where("(max_for_total >= ?) AND (min_for_total <= ?)", phase, phase).first.id
  end

  def call_tweet_share(question_count)
    "https://twitter.com/intent/tweet?text=" +
    "あなたはゲームモードで" + "%0a" + "【#{question_count}問】クリアできました！" + "%0a%0a" + "「#{self.recording_results.last.recognized_english.truncate(95)}」" + "%0a" + "の発音精度は" + "%0a%0a" + "発音の正確さ　#{self.recording_results.last.accuracy_score}点" + "%0a" + "発音の流暢さ　#{self.recording_results.last.fluency_score}点" + "%0a" + "発音の完全度　#{self.recording_results.last.completeness_score}点" + "%0a%0a" + "です！" + "%0a" + '%23' + "SpeakingChecker" + "%0a" +
    "&url=https://www.speaking-checker.com/"
  end
end
