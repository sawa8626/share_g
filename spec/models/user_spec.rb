require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての値が正しく入力されていれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailに@が含まれていなければ登録できないこと' do
      @user.email = 'test.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email need to include @')
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下では登録できないこと' do
      @user.password = 'test1'
      @user.password_confirmation = 'test1'
      @user.valid?
      expect(@user.errors.full_messages).to be_include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合でなければ登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password include both letters and numbers')
    end

    it 'passwordが正しく入力されていてもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'first_nameが空では登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが全角日本語以外では登録できないこと' do
      @user.first_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name full-width characters')
    end

    it 'last_nameが空では登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが全角日本語以外では登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name full-width characters')
    end

    it 'first_name_kanaが空では登録できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana full-width katakana characters')
    end

    it 'first_name_kanaが全角カタカナ以外では登録できないこと' do
      @user.first_name_kana = 'ﾔﾏﾀﾞ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana full-width katakana characters')
    end

    it 'last_name_kanaが空では登録できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana full-width katakana characters')
    end

    it 'last_name_kanaが全角カタカナ以外では登録できないこと' do
      @user.last_name_kana = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana full-width katakana characters')
    end

    it 'phone_numberが空では登録できないこと' do
      @user.phone_number = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが12桁以上では登録できないこと' do
      @user.phone_number = '0901234567890'
      @user.valid?
      expect(@user.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
    end

    it 'adminが空では登録できないこと' do
      @user.admin = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Admin is not included in the list')
    end

    it 'adminがtrueでは登録できないこと' do
      @user.admin = true
      @user.valid?
      expect(@user.errors.full_messages).to include('Admin is not included in the list')
    end
  end
end
