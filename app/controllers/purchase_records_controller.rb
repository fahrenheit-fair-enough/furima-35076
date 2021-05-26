class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @product = Product.find(params[:product_id])
    @purchase_address = PurchaseAddress.new
  end



  def create
    @product = Product.find(params[:product_id])
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(product_id: params[:product_id],user_id: current_user.id)
  end

  # 削除
  # def address_params
  #   params.permit(:postal_code, :prefecture, :city, :house_number, :building_name).merge(donation_id: @donation.id)
  # end
end


# README purchase records テーブル 参照に記入
# | Column    | Type       | Options           |
# | --------- | ---------- | ----------------- |
# | user      | references | foreign_key: true |
# | product   | references | foreign_key: true |

### Association

# - belongs_to :user
# - belongs_to :product
# - has_one :shipping_address



# README shipping address テーブル 参照に記入
# | Column                | Type       | Options           |
# | --------------------- | ---------- | ----------------- |
# | postal_code           | string     | null: false       |
# | prefecture_id         | integer    | null: false       |
# | city                  | string     | null: false       |
# | addresses             | string     | null: false       |
# | building              | string     |                   |
# | phone_number          | string     | null: false       |
# | purchase_record       | references | foreign_key: true |

## Association

# - belongs_to :purchase_record
