class OrdersController < ApplicationController
  def new
    @pizza = Pizza.find_by(id:params[:pizza_id])
    @crusts = Crust.all
    @side_items = SideItem.all
    @category = Category.where("name=? OR id=?","base", @pizza.category_id)
    @toppings = Topping.where(category_id:@category.pluck(:id))
    @order = Order.new
  end 

  def create
    @order = Order.new(order_params)
    @pizza = Pizza.find(order_params[:pizza_id])
    if @order.save
      side_item = SideItem.find(params[:order][:side_item_ids])
      side_order_item = side_item.order_items.create(order_id:@order.id, price:side_item.price)
      toppings = Topping.where(id: params[:order][:topping_ids])
      toppings.each do |topping|
        topping.order_items.create(order_id:@order.id,price: (topping.price)*order_params[:quantity].to_i)
      end

      price = if order_params[:size] =="Large"
        topping_price = 0
        if toppings.count>2
          topping_price = toppings.limit(toppings.count-2).pluck(:price).sum
        end
        
        @pizza.large_price+topping_price+(side_item&.price).to_i
      elsif order_params[:size] =="Medium"
        @pizza.medium_price+toppings.pluck(:price).sum+(side_item&.price).to_i
      else
        @pizza.regular_price+toppings.pluck(:price).sum+(side_item&.price).to_i
      end 
      @order.update(status:"ordered",price:price)
        redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      flash.now[:alert]
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def order_params
    params.require(:order).permit(:pizza_id,:crust_id, :quantity, :size)
  end
end
