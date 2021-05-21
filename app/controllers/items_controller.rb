class ItemsController < ApplicationController
  def index
  end


  def new
    @product = Producto.new
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
    params.require(:product).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
