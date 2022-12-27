require 'rails_helper'

RSpec.describe TotalResult, type: :model do
  let(:total_result) { FactoryBot.build(:total_result) }
  let(:best_total_result_with_no_rank) { FactoryBot.build(:total_result, :best_total_result, rank_id: nil) }
  let(:good_total_result_with_no_rank) { FactoryBot.build(:total_result, :good_total_result, rank_id: nil) }
  let(:normal_total_result_with_no_rank) { FactoryBot.build(:total_result, :normal_total_result, rank_id: nil) }
  let(:little_bad_total_result_with_no_rank) { FactoryBot.build(:total_result, :little_bad_total_result, rank_id: nil) }
  let(:bad_total_result_with_no_rank) { FactoryBot.build(:total_result, :bad_total_result, rank_id: nil) }

  describe 'インスタンスメソッド機能' do
    describe 'judge_rank' do
      FactoryBot.create(:rank, :best_rank)
      FactoryBot.create(:rank, :good_rank)
      FactoryBot.create(:rank, :normal_rank)
      FactoryBot.create(:rank, :little_bad_rank)
      FactoryBot.create(:rank, :bad_rank)

      context 'クリアした問題の最高phaseが10の場合' do
        it 'rank_idがbest_rankのidである' do
          best_total_result_with_no_rank.judge_rank(10)
          expect(best_total_result_with_no_rank.rank.evaluation).to eq "帰国子女レベル"
        end
      end

      context 'クリアした問題の最高phaseが7の場合' do
        it 'rank_idがgood_rankのidである' do
          good_total_result_with_no_rank.judge_rank(7)
          expect(good_total_result_with_no_rank.rank.evaluation).to eq "海外旅行経験者レベル"
        end
      end

      context 'クリアした問題の最高phaseが5の場合' do
        it 'rank_idがnormal_rankのidである' do
          normal_total_result_with_no_rank.judge_rank(5)
          expect(normal_total_result_with_no_rank.rank.evaluation).to eq "英会話スクール初学者レベル"
        end
      end

      context 'クリアした問題の最高phaseが3の場合' do
        it 'rank_idがlittle_bad_rankのidである' do
          little_bad_total_result_with_no_rank.judge_rank(3)
          expect(little_bad_total_result_with_no_rank.rank.evaluation).to eq "小学校高学年レベル"
        end
      end

      context 'クリアした問題の最高phaseが1の場合' do
        it 'rank_idがbad_rankのidである' do
          bad_total_result_with_no_rank.judge_rank(1)
          expect(bad_total_result_with_no_rank.rank.evaluation).to eq "チンパンジーレベル"
        end
      end
    end

    describe 'judge_phase' do
      context 'クリアした最後の問題のphaseが10で且つ、average_scoreが90点以上の場合' do
        it '10を返す' do
          FactoryBot.create(:recording_result, :best_recording_result, total_result: total_result)
          expect(total_result.judge_phase(phase: 10, score: total_result.recording_results.last.average_score)).to eq 10
        end
      end

      context 'クリアした最後の問題のaverage_scoreが90点以下の場合' do
        it 'judge_phaseのphaseに渡した数値より1小さい値を返す' do
          FactoryBot.create_list(:recording_result, 5, total_result: total_result)
          result_count = total_result.recording_results.count
          expect(total_result.judge_phase(phase: result_count, score: total_result.recording_results.last.average_score)).to eq (result_count - 1)
        end
      end
    end
  end
end
