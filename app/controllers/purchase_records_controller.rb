class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :back_to_top
  before_action :production

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      product_id: params[:product_id], user_id: current_user.id, token: params[:token]
    )
  end

  def production
    @product = Product.find(params[:product_id])
  end

  def back_to_top
    @product = Product.find(params[:product_id])
    redirect_to root_path if current_user.id == @product.user_id || !@product.purchase_record.nil?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_address_params[:token],
      currency: 'jpy'
    )
  end
end

