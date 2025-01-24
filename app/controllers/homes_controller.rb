class HomesController < ApplicationController
  def index
      @veg_category = Category.find_by(name:"Vegetarian")
      @non_veg_category = Category.find_by(name:"Non-Vegetarian") 
      @veg_pizza = @veg_category.pizzas
      @non_veg_pizza = @non_veg_category.pizzas
      @crusts = Crust.all
      @side_items = SideItem.all
      @topping = Topping.all
  end
end
