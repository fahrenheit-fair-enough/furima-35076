require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      sleep(0.5)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, product_id: @product.id)
    end



          # ログイン状態の出品者以外のユーザーのみ、必要な情報を適切に入力すると、商品の購入ができること
          # 参照記述事項
          # :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number,


    context '商品の購入ができる時' do
      it 'ログイン状態の出品者以外のユーザーのみが購入商品選択時、postal_code、prefecture_id、city、addresses、phone_number、を適切に入力すると、商品の購入ができること' do
        expect(@purchase_address).to be_valid
      end

      it 'ログイン状態の出品者以外のユーザーのみが購入商品選択時、building、が空欄でも商品の購入ができること' do
        expect(@purchase_address).to be_valid
      end
    end


          # 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
          # 郵便番号の保存にはハイフンが必要であること（123-4567となる）
          # 電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）



          # ユーザー情報 # 商品情報 # 郵便番号

    context '商品の購入ができない時' do
      it '出品者以外のユーザーがログイン時でないと購入できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it '購入商品情報がないと購入できないこと' do
        @purchase_address.product_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Product can't be blank")
      end

      it '郵便番号がないと購入できないこと' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号はハイフンがないと保存できないこと' do
        @purchase_address.postal_code = 1234567
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

          # 都道府県

      it '都道府県がないと購入できないこと' do
        @purchase_address.prefecture_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end

      it '都道府県が---では購入できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

          # 市区町村

      it '市区町村がないと購入できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

          # 番地

      it '番地がないと購入できないこと' do
        @purchase_address.addresses = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Addresses can't be blank")
      end

          # 電話番号

      it '電話番号がないと購入できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は11桁以上の数値は保存できないこと' do
        @purchase_address.phone_number = "090123456789"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end



          # クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと



      it 'クレジットカード情報がないと決済できないこと' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end