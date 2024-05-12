require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべての情報が入力されてるとき' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空のとき' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空のとき' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが重複してるとき' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が存在しないとき' do
        @user.email = Faker::Internet.email.gsub('@', '')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空のとき' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下のとき' do
        @user.password = Faker::Internet.password(min_length: 5, max_length: 5)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが数字だけのとき' do
        @user.password = Faker::Number.number(digits: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end

      it 'passwordが半角英字だけのとき' do
        @user.password = Faker::Internet.password(min_length: 12).gsub!(/\d/, '')
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end

      it 'passwordが全角文字のとき' do
        @user.password = @user.last_name * 5
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end

      it 'passwordとpassword_confirmationが不一致のとき' do
        @user.password_confirmation += '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが空のとき' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが全角(漢字・ひらがな・カタカナ)以外のとき' do
        @user.last_name = NKF.nkf('-w -Z4', @user.last_name_kana)
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end

      it 'first_nameが空のとき' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角(漢字・ひらがな・カタカナ)以外のとき' do
        @user.first_name = NKF.nkf('-w -Z4', @user.first_name_kana)
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end

      it 'last_name_kanaが空のとき' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaが全角(カタカナ)以外のとき' do
        @user.last_name_kana = NKF.nkf('-w -Z4', @user.last_name_kana)
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end

      it 'first_name_kanaが空のとき' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが全角(カタカナ)以外のとき' do
        @user.first_name_kana = NKF.nkf('-w -Z4', @user.first_name_kana)
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end

      it 'birth_dateが空のとき' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
