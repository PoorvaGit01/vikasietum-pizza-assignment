class OrdersController < ApplicationController
  before_action :authorize_customer!, only: [:new ]
  def index
    if current_user.vendor?
      @orders = Order.where.not(status:"pending")
    else
      @orders = current_user.orders&.where.not(status:"pending")
    end
  end

  def new
    @pizza = Pizza.find_by(id:params[:pizza_id])
    @crusts = Crust.where("quantity>?",0)
    @side_items = SideItem.where("quantity>?",0)
    @category = Category.where("name=? OR id=?","base", @pizza.category_id)
    @all_toppings = Topping.where(category_id:@category.pluck(:id))
    @toppings = @all_toppings.where("quantity>?",0)
    @order = Order.new
  end 

  def create
    @order = Order.new(order_params.merge({ user_id: current_user.id }))
    @pizza = Pizza.find(order_params[:pizza_id])
    
    ActiveRecord::Base.transaction do
      if @order.save
        @pizza.decrement!(:quantity, @order.quantity) if @pizza.quantity >= @order.quantity
        
        side_item = SideItem.find(params[:order][:side_item_ids])
        side_order_item = side_item.order_items.create(order_id: @order.id, price: side_item.price)
        side_item.decrement!(:quantity, @order.quantity) if side_item.quantity >= @order.quantity
  
        toppings = Topping.where(id: params[:order][:topping_ids])
        toppings.each do |topping|
          topping.order_items.create(order_id: @order.id, price: topping.price * @order.quantity)
          topping.decrement!(:quantity, @order.quantity) if topping.quantity >= @order.quantity
        end
  
        price = if order_params[:size] == "Large"
                  topping_price = 0
                  if toppings.count > 2
                    topping_price = toppings.limit(toppings.count - 2).pluck(:price).sum
                  end
  
                  @pizza.large_price + topping_price + (side_item&.price.to_i)
                elsif order_params[:size] == "Medium"
                  @pizza.medium_price + toppings.pluck(:price).sum + (side_item&.price.to_i)
                else
                  @pizza.regular_price + toppings.pluck(:price).sum + (side_item&.price.to_i)
                end
  
        @order.update!(status: "ordered", price: price)
  
        redirect_to order_path(@order), notice: "Order placed successfully!"
      else
        flash.now[:alert] = "Error placing order."
        render :new
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Error: #{e.message}"
    render :new
  end
  

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def order_params
    params.require(:order).permit(:pizza_id,:crust_id, :quantity, :size)
  end
end
