class ProductsController < ApplicationController
  def index
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

  private

  def product_params
    params.require(:product).permit(:name, :explain, :category_id, :status_id, :shipping_free_status_id, :prefecture_id,
                                    :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
end
