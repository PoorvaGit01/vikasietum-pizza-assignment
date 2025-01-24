class InventoryService
    def initialize(order, pizza, side_item, toppings)
      @order = order
      @pizza = pizza
      @side_item = side_item
      @toppings = toppings
    end
  
    def update_stock
      @pizza.decrement!(:quantity, @order.quantity) if @pizza.quantity >= @order.quantity
      
      if @side_item
        @side_item.order_items.create(order_id: @order.id, price: @side_item.price)
        @side_item.decrement!(:quantity, @order.quantity) if @side_item.quantity >= @order.quantity
      end
  
      @toppings.each do |topping|
        topping.order_items.create(order_id: @order.id, price: topping.price * @order.quantity)
        topping.decrement!(:quantity, @order.quantity) if topping.quantity >= @order.quantity
      end
    end
  end