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
        expect(@purchase_address.errors.full_messages).to include("Userを入力してください")
      end

      it '購入商品情報がないと購入できないこと' do
        @purchase_address.product_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Productを入力してください")
      end

      it '郵便番号がないと購入できないこと' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号をハイフンを加えて入力してください")
      end

      it '郵便番号はハイフンがないと保存できないこと' do
        @purchase_address.postal_code = '1_234_567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('郵便番号をハイフンを加えて入力してください')
      end

      # 都道府県

      it '都道府県がないと購入できないこと' do
        @purchase_address.prefecture_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("発送元の地域を入力してください", "発送元の地域は数値で入力してください")
      end

      it '都道府県が---では購入できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
      end

      # 市区町村

      it '市区町村がないと購入できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
      end

      # 番地

      it '番地がないと購入できないこと' do
        @purchase_address.addresses = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
      end

      # 電話番号

      it '電話番号がないと購入できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は数値で入力してください")
      end

      it '電話番号は11桁以上の数値は保存できないこと' do
        @purchase_address.phone_number = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end

      it '電話番号は英数混合では保存できないこと' do
        @purchase_address.phone_number = '01234abcdef'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は数値で入力してください')
      end

      # クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと

      it 'クレジットカード情報がないと決済できないこと' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
