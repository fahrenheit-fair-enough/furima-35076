require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid

    end



    it 'nick_nameが空では登録できないこと' do
      @user.nick_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nick name can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '123ab'
      @user.password_confirmation = '123ab'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@がないと登録できないこと' do
      @user.email = 'abcgmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'family_nameが全角入力でなければ登録できないこと' do
      @user.family_name = "ｱｲｳｴｵ"
      @user.valid?
      expect(@user.errors[:family_name]).to include("is invalid. Input full-width characters.")
    end

    it 'first_nameが全角入力でなければ登録できないこと' do
      @user.first_name = "ｱｲｳｴｵ"
      @user.valid?
      expect(@user.errors[:first_name]).to include("is invalid. Input full-width characters.")
    end

    it 'family_name_kanaが全角カタカナでなければ登録できないこと' do
      @user.family_name_kana = "あいうえお"
      @user.valid?
      expect(@user.errors[:family_name_kana]).to include("is invalid. Input full-width katakana characters.")
    end

    it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
      @user.first_name_kana = "あいうえお"
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("is invalid. Input full-width katakana characters.")
    end

    it "password_confirmationがない場合は登録できないこと" do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "birth_dateがない場合は登録できないこと" do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors[:birth_date]).to include("can't be blank")
    end

    it 'パスワードが数字のみの場合、登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードが英字のみの場合、登録できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

  end
end
