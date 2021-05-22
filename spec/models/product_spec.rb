require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    before do
      @product = FactoryBot.build(:product)
    end

    context '商品の出品ができる時' do
      it 'ユーザーログイン時にimage、name、explain、category_id、status_id、shipping_free_status_id、prefecture_id、scheduled_delivery_id、price、が存在すれば出品できること' do
        expect(@product).to be_valid
      end
    end



            # 商品画像を1枚つけることが必須であること
            # 商品名が必須であること
            # 商品の説明が必須であること
            # カテゴリーの情報が必須であること
            # 商品の状態についての情報が必須であること
            # 配送料の負担についての情報が必須であること
            # 発送元の地域についての情報が必須であること
            # 発送までの日数についての情報が必須であること
            # 販売価格についての情報が必須であること
            # 販売価格は、¥300~¥9,999,999の間のみ保存可能であること
            # 販売価格は半角数字のみ保存可能であること



    context '商品の出品ができない時' do
      it 'imageがないと登録できないこと' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がないと登録できないこと' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明がないと登録できないこと' do
        @product.explain = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Explain can't be blank")
      end

      it 'カテゴリーの情報がないと登録できないこと' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態についての情報がないと登録できないこと' do
        @product.status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担についての情報がないと登録できないこと' do
        @product.shipping_free_status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping free status can't be blank")
      end

      it '発送元の地域についての情報がないと登録できないこと' do
        @product.prefecture_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数についての情報がないと登録できないこと' do
        @product.scheduled_delivery_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it '販売価格についての情報がないと登録できないこと' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end


      # 販売価格は、¥300~¥9,999,999の間のみ保存可能であること


      it '販売価格は、¥0~¥299は登録できないこと' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not included in the list")
      end


      it '販売価格は、¥10,000,000~は登録できないこと' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not included in the list")
      end


            # 販売価格は半角数字のみ保存可能であること


      it '販売価格は全角数字は登録できないこと' do
        @product.price = '１２３４５'
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not included in the list")
      end

    end
  end
end
