require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, product_id: @product.id)
    end
  end
end




# ログイン状態の出品者以外のユーザーのみ、必要な情報を適切に入力すると、商品の購入ができること



# 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
# 郵便番号の保存にはハイフンが必要であること（123-4567となる）
# 電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）