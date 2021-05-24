class ProductsController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show ]
  before_action :@product = Product.find(params[:id]), only: [:show, :edit, :update ]

  def index
    @products = Product.includes(:user).order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user.id != @product.user_id
  end

  def update
    if @product.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :explain, :category_id, :status_id, :shipping_free_status_id, :prefecture_id,
                                    :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
end
