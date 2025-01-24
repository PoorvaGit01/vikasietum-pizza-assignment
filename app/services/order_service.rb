class OrderService
    def initialize(order, pizza, side_item, toppings, quantity)
      @order = order
      @pizza = pizza
      @side_item = side_item
      @toppings = toppings
      @quantity = quantity.to_i
    end
  
    def calculate_price
      if @order.size == "Large"
        topping_price = @toppings.count > 2 ? @toppings.limit(@toppings.count - 2).pluck(:price).sum : 0
        @pizza.large_price*@quantity + topping_price*@quantity + (@side_item&.price.to_i)
      elsif @order.size == "Medium"
        @pizza.medium_price*@quantity + (@toppings.pluck(:price).sum)*@quantity + (@side_item&.price.to_i)
      else
        @pizza.regular_price*@quantity + (@toppings.pluck(:price).sum)*@quantity + (@side_item&.price.to_i)
      end
    end
  end  