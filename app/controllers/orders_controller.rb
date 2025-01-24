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
    side_item = SideItem.find_by(id: params[:order][:side_item_ids])
    toppings = Topping.where(id: params[:order][:topping_ids])

    ActiveRecord::Base.transaction do
      if @order.save
        InventoryService.new(@order, @pizza, side_item, toppings).update_stock

        price = OrderService.new(@order, @pizza, side_item, toppings, order_params[:quantity]).calculate_price
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

  private

  def order_params
    params.require(:order).permit(:pizza_id,:crust_id, :quantity, :size)
  end
end
