class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_vendor!

  def index
    @pizzas = Pizza.all
    @crusts = Crust.all
    @toppings = Topping.all
    @side_items = SideItem.all
  end

  def edit
    @product_type = params[:product_type]
    @product = find_product(params[:id], @product_type)
  end

  def update
    @product_type = params.keys[2]
    @product = find_product(params[:id], @product_type)

    if @product.update(product_params)
      redirect_to root_path, notice: "#{@product.name} updated successfully!"
      # redirect_to inventory_path, notice: "#{@product.name} updated successfully!"
    else
      render :edit
    end
  end
  private

  def check_vendor_role
    unless current_user.vendor?
      redirect_to root_path, alert: "You do not have access to this page."
    end
  end

  def find_product(id, product_type)
    case product_type
    when 'pizza'
      Pizza.find(id)
    when 'crust'
      Crust.find(id)
    when 'topping'
      Topping.find(id)
    when 'side_item'
      SideItem.find(id)
    else
      redirect_to inventory_path, alert: "Product type not found"
    end
  end

  def product_params
    params.require(@product_type.to_sym).permit(:quantity)
  end

end
