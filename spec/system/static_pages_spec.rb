require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  let!(:question) { FactoryBot.create(:question, phase: 1) }

  describe 'トップページ' do
    before do
      visit root_path
    end

    context 'アプリの概要説明ページに遷移' do
      before do
        click_on "Speaking Checkerとは?"
      end

      it 'アプリの概要説明ページが表示される' do
        expect(page).to have_content "Speaking Checkerとは"
        expect(page).to have_link "トップへ"
      end
    end

    context '利用規約ページに遷移' do
      before do
        click_on "利用規約"
      end

      it '利用規約ページが表示される' do
        expect(page).to have_content "利用規約"
        expect(page).to have_link "トップへ"
      end
    end

    context 'プライバシーポリシーページに遷移' do
      before do
        click_on "プライバシーポリシー"
      end

      it 'プライバシーポリシーページが表示される' do
        expect(page).to have_content "プライバシーポリシー"
        expect(page).to have_link "トップへ"
      end
    end

    context 'お問合せページに遷移' do
      before do
        click_on "お問い合わせ先"
      end

      it 'お問合せページが表示される' do
        expect(page).to have_content "お問い合わせ先"
        expect(page).to have_content "@maekawayoshitaka"
        expect(page).to have_link "トップへ"
      end
    end
  end
end
