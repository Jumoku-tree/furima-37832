require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる時' do
      it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移する' do
      enter_basic_auth(root_path)
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in "nickname", with: @user.nickname
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      fill_in "last-name", with: @user.kanji_family_name
      fill_in "first-name", with: @user.kanji_first_name
      fill_in "last-name-kana", with: @user.kana_family_name
      fill_in "first-name-kana", with: @user.kana_first_name
      find("#user_birthday_1i").find('option[value="1930"]').select_option
      find("#user_birthday_2i").find('option[value="1"]').select_option
      find("#user_birthday_3i").find('option[value="1"]').select_option
      expect{
      find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')

      end
    end
    context 'ユーザー新規登録ができない時' do
      it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
        enter_basic_auth(root_path)
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        fill_in "nickname", with: ''
        fill_in "email", with: ''
        fill_in "password", with: ''
        fill_in "password-confirmation", with: ''
        fill_in "last-name", with: ''
        fill_in "first-name", with: ''
        fill_in "last-name-kana", with: ''
        fill_in "first-name-kana", with: ''
        expect{
          find('input[name="commit"]').click
      }.to change { User.count }.by(0)
        expect(current_path).to eq user_registration_path
      end
  
    end
  end

  describe 'ユーザーログイン' do
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        enter_basic_auth(root_path)
        @user.save
        visit root_path
        expect(page).to have_content("ログイン")
        sign_in(@user)
        expect(page).to have_content("ログアウト")
        expect(page).to have_no_content("ログイン")
        expect(page).to have_no_content("新規登録")
      end
    end

    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        enter_basic_auth(root_path)
        @user.save
        visit root_path
        expect(page).to have_content("ログイン")
        visit new_user_session_path
        fill_in "email", with: ""
        fill_in "password", with: ""
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
