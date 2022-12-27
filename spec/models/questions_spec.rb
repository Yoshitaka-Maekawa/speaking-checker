require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryBot.build(:question) }
  let(:question_with_no_english_text) { FactoryBot.build(:question, english_text: nil) }
  let(:question_with_no_phase) { FactoryBot.build(:question, phase: nil) }
  let(:question_with_japanese) { FactoryBot.build(:question, english_text: "問題") }
  let(:question_with_percent) { FactoryBot.build(:question, english_text: "100%") }
  let(:question_with_first_lower_case) { FactoryBot.build(:question, english_text: "question.") }
  let(:question_not_end_with_comma_and_?) { FactoryBot.build(:question, english_text: "Question") }

  describe 'バリデーション機能' do
    context 'english_text,phaseが存在すれば' do
      it '有効な状態であること' do
        expect(question).to be_valid
      end
    end

    context 'english_textが保存されていない時' do
      it 'validationエラーが発生' do
        question_with_no_english_text.valid?
        expect(question_with_no_english_text.errors[:english_text]).to include("を入力してください")
      end
    end

    context 'phaseが保存されていない時' do
      it 'validationエラーが発生' do
        question_with_no_phase.valid?
        expect(question_with_no_phase.errors[:phase]).to include("を入力してください")
      end
    end

    context 'english_textに日本語を含んでる時' do
      it 'カスタムvalidationエラーが発生' do
        question_with_japanese.valid?
        expect(question_with_japanese.errors[:english_text]).to include("を入力してください。日本語は入力不可です。")
      end
    end

    context 'english_textに%を含んでる時' do
      it 'カスタムvalidationエラーが発生' do
        question_with_percent.valid?
        expect(question_with_percent.errors[:english_text]).to include('における "%" は "percent" で入力してください。')
      end
    end

    context 'english_textの最初の文字が小文字の場合' do
      it 'カスタムvalidationエラーが発生' do
        question_with_first_lower_case.valid?
        expect(question_with_first_lower_case.errors[:english_text]).to include("の先頭の文字は大文字で入力してください。")
      end
    end

    context 'english_textがカンマ、または?で終わってない場合' do
      it 'カスタムvalidationエラーが発生' do
        question_not_end_with_comma_and_?.valid?
        expect(question_not_end_with_comma_and_?.errors[:english_text]).to include("の末尾にカンマ(.)またはクエスチョンマーク(?)を入力してください。")
      end
    end
  end
end
