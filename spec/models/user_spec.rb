require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての項目が入力されていれば登録できる' do
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに@を含まなければ登録できない' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordがアルファベットのみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both alphabet and number')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both alphabet and number')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'kanji_family_nameが空では登録できない' do
        @user.kanji_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji family name can't be blank")
      end

      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name can't be blank")
      end

      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name can't be blank")
      end

      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end

      it 'kana_family_nameが全角カタカナでなければ登録できない' do
        @user.kana_family_name = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family name must be 2-byte katakana')
      end

      it 'kana_first_nameが全角カタカナでなければ登録できない' do
        @user.kana_first_name = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name must be 2-byte katakana')
      end

      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '重複したメールアドレスは登録できない' do
        @user.save
        another = FactoryBot.build(:user)
        another.email = @user.email
        another.valid?
        expect(another.errors.full_messages).to include('Email has already been taken')
      end

      it '全角文字を含むパスワードは登録できない' do
        @user.password = 'aa11ぱす'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both alphabet and number')
      end

      it 'kanji_family_nameに半角文字が含まれていると登録できない' do
        @user.kanji_family_name = 'iida'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji family name must be 2-byte hiragana, katakana, or kanji')
      end

      it 'kanji_first_nameに半角文字が含まれていると登録できない' do
        @user.kanji_first_name = 'tenya'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji first name must be 2-byte hiragana, katakana, or kanji')
      end
    end
  end
end
