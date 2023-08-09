require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての入力事項が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
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
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", 'Password Include both letters and numbers', "Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123654'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        # binding.pry
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaaaamail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordが半角数字のみのときに登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordが半角英語のみのときに登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid. Input full-width characters.")
      end
      it 'family_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.family_name = 'yamada'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid. Input full-width characters.")
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name = 'rikutaro'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana is invalid. Input full-width katakana characters.")
      end
      it 'family_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.family_name_kana = 'やまだ'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('Family name kana is invalid. Input full-width katakana characters.')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid. Input full-width katakana characters.")
      end
      it 'first_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        #binding.pry
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
