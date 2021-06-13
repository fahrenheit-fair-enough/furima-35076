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
        expect(@product.errors.full_messages).to include('商品画像を入力してください')
      end

      it '商品名がないと登録できないこと' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('商品名を入力してください')
      end

      it '商品の説明がないと登録できないこと' do
        @product.explain = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('商品説明を入力してください')
      end

      it 'カテゴリーの情報がないと登録できないこと' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('カテゴリーを入力してください', 'カテゴリーは数値で入力してください')
      end

      it '商品の状態についての情報がないと登録できないこと' do
        @product.status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の状態を入力してください', '商品の状態は数値で入力してください')
      end

      it '配送料の負担についての情報がないと登録できないこと' do
        @product.shipping_free_status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('配送料の負担を入力してください', '配送料の負担は数値で入力してください')
      end

      it '発送元の地域についての情報がないと登録できないこと' do
        @product.prefecture_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('発送元の地域を入力してください', '発送元の地域は数値で入力してください')
      end

      it '発送までの日数についての情報がないと登録できないこと' do
        @product.scheduled_delivery_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('発送までの日数を入力してください', '発送までの日数は数値で入力してください')
      end

      it '販売価格についての情報がないと登録できないこと' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません', '販売価格を入力してください')
      end

      # 下記models/product.rbを参照に、アクティブハッシュの5つのカラムについてバリデーションであるother_than: 1 を確かめるテストを5つ
      # with_options numericality: { other_than: 1 } do
      #   validates :category_id
      #   validates :status_id
      #   validates :shipping_free_status_id
      #   validates :prefecture_id
      #   validates :scheduled_delivery_id

      it 'カテゴリーの情報が---では登録できないこと' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end

      it '商品の状態についての情報が---では登録できないこと' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の状態は1以外の値にしてください')
      end

      it '配送料の負担についての情報が---では登録できないこと' do
        @product.shipping_free_status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
      end

      it '発送元の地域についての情報が---では登録できないこと' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
      end

      it '発送までの日数についての情報が---では登録できないこと' do
        @product.scheduled_delivery_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
      end

      # 販売価格は、¥300~¥9,999,999の間のみ保存可能であること

      it '販売価格は、¥0~¥299は登録できないこと' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません')
      end

      it '販売価格は、¥10,000,000~は登録できないこと' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません')
      end

      # 販売価格は半角数字のみ保存可能であること

      it '販売価格は全角数字では登録できないこと' do
        @product.price = '１２３４５'
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません')
      end

      it '販売価格は英数字混合では登録できないこと' do
        @product.price = '123abc'
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません')
      end

      it '販売価格は半角英語のみでは登録できないこと' do
        @product.price = 'abcdef'
        @product.valid?
        expect(@product.errors.full_messages).to include('販売価格は一覧にありません')
      end
    end
  end
end
