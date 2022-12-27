require 'rails_helper'

RSpec.describe RecordingResult, type: :model do
  let(:recording_result) { FactoryBot.create(:recording_result) }
  let(:recording_result_with_no_recognized_english) { FactoryBot.build(:recording_result, recognized_english: nil) }
  let(:recording_result_with_no_average_score) { FactoryBot.build(:recording_result, average_score: nil) }
  let(:recording_result_with_no_accuracy_score) { FactoryBot.build(:recording_result, accuracy_score: nil) }
  let(:recording_result_with_no_fluency_score) { FactoryBot.build(:recording_result, fluency_score: nil) }
  let(:recording_result_with_no_completeness_score) { FactoryBot.build(:recording_result, completeness_score: nil) }
  let(:best_recording_result_with_no_rank) { FactoryBot.build(:recording_result, :best_recording_result, rank_id: nil) }
  let(:good_recording_result_with_no_rank) { FactoryBot.build(:recording_result, :good_recording_result, rank_id: nil) }
  let(:normal_recording_result_with_no_rank) { FactoryBot.build(:recording_result, :normal_recording_result, rank_id: nil) }
  let(:little_bad_recording_result_with_no_rank) { FactoryBot.build(:recording_result, :little_bad_recording_result, rank_id: nil) }
  let(:bad_recording_result_with_no_rank) { FactoryBot.build(:recording_result, :bad_recording_result, rank_id: nil) }

  describe 'バリデーション機能' do
    context 'recognized_english,全てのスコア,関連対象の親idが存在すれば' do
      it '有効な状態であること' do
        expect(recording_result).to be_valid
      end
    end

    context 'recognized_englishが保存されてない場合' do
      it 'validationエラーが発生する' do
        recording_result_with_no_recognized_english.valid?
        expect(recording_result_with_no_recognized_english.errors[:recognized_english]).to include(("を入力してください"))
      end
    end

    context 'average_scoreが保存されてない場合' do
      it 'validationエラーが発生する' do
        recording_result_with_no_average_score.valid?
        expect(recording_result_with_no_average_score.errors[:average_score]).to include(("を入力してください"))
      end
    end

    context 'accuracy_scoreが保存されてない場合' do
      it 'validationエラーが発生する' do
        recording_result_with_no_accuracy_score.valid?
        expect(recording_result_with_no_accuracy_score.errors[:accuracy_score]).to include(("を入力してください"))
      end
    end

    context 'fluency_scoreが保存されてない場合' do
      it 'validationエラーが発生する' do
        recording_result_with_no_fluency_score.valid?
        expect(recording_result_with_no_fluency_score.errors[:fluency_score]).to include(("を入力してください"))
      end
    end

    context 'completeness_scoreが保存されてない場合' do
      it 'validationエラーが発生する' do
        recording_result_with_no_completeness_score.valid?
        expect(recording_result_with_no_completeness_score.errors[:completeness_score]).to include(("を入力してください"))
      end
    end
  end

  describe 'インスタンスメソッド機能' do
    describe 'judge_rank' do
      FactoryBot.create(:rank, :best_rank)
      FactoryBot.create(:rank, :good_rank)
      FactoryBot.create(:rank, :normal_rank)
      FactoryBot.create(:rank, :little_bad_rank)
      FactoryBot.create(:rank, :bad_rank)

      context 'average_scoreがbest_rankの範囲内の場合' do
        it 'rank_idがbest_rankのidである' do
          best_recording_result_with_no_rank.judge_rank
          expect(best_recording_result_with_no_rank.rank.evaluation).to eq "帰国子女レベル"
        end
      end

      context 'average_scoreがgood_rankの範囲内の場合' do
        it 'rank_idがgood_rankのidである' do
          good_recording_result_with_no_rank.judge_rank
          expect(good_recording_result_with_no_rank.rank.evaluation).to eq "海外旅行経験者レベル"
        end
      end

      context 'average_scoreがnormal_rankの範囲内の場合' do
        it 'rank_idがnormal_rankのidである' do
          normal_recording_result_with_no_rank.judge_rank
          expect(normal_recording_result_with_no_rank.rank.evaluation).to eq "英会話スクール初学者レベル"
        end
      end

      context 'average_scoreがlittle_bad_rankの範囲内の場合' do
        it 'rank_idがlittle_bad_rankのidである' do
          little_bad_recording_result_with_no_rank.judge_rank
          expect(little_bad_recording_result_with_no_rank.rank.evaluation).to eq "小学校高学年レベル"
        end
      end

      context 'average_scoreがbad_rankの範囲内の場合' do
        it 'rank_idがbad_rankのidである' do
          bad_recording_result_with_no_rank.judge_rank
          expect(bad_recording_result_with_no_rank.rank.evaluation).to eq "チンパンジーレベル"
        end
      end
    end
  end
end
