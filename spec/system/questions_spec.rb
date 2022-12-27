require 'rails_helper'

RSpec.describe 'Question', type: :system do
  let!(:total_result) { FactoryBot.create(:total_result) }
  let!(:question_1) { FactoryBot.create(:question, phase: 1) }
  let(:rspec_session) { { total_result: total_result } }

  describe '既に問題が作成されているゲームモード時' do
    FactoryBot.create(:question, phase: 2)

    context 'ゲームモードのボタンを押した時' do
      before do
        visit root_path
        click_on "ゲームモードで腕試し"
      end

      it '第一問が表示される' do
        expect(current_path).to eq question_path(question_1)
        expect(page).to have_content question_1.english_text
        expect(page).to have_content question_1.meaning
        expect(page).to have_content "ボタンを押して発音をチェック!!"
        expect(page).to have_link "トップへ"
      end
    end
  end

  describe '問題作成機能' do
    let(:recommended_question) { FactoryBot.create(:question, english_text: "Recommended question.", meaning: "おすすめの問題", phase: 0) }
    let!(:recording_result) { FactoryBot.create(:recording_result, :normal_recording_result, question: recommended_question) }

    context '問題文を記入し、送信ボタンを押した時' do
      before do
        visit new_question_path
        fill_in "question_english_text", with: "Question."
        click_on "送信"
        sleep 5.0
      end

      it '作成した問題文が表示される' do
        expect(page).to have_content "Question."
        expect(page).to have_button "ボタンを押して発音をチェック!!"
        expect(page).to have_link "トップへ"
      end
    end
  end
end
