class HomesController < ApplicationController
  before_action :authenticate_user!
  def index
      @veg_category = Category.find_by(name:"Vegetarian")
      @non_veg_category = Category.find_by(name:"Non-Vegetarian") 
      @veg_pizza = @veg_category.pizzas.where("quantity>?",0)
      @non_veg_pizza = @non_veg_category.pizzas.where("quantity>?",0)
      @crusts = Crust.where("quantity>?",0)
      @side_items = SideItem.where("quantity>?",0)
      @topping = Topping.where("quantity>?",0)
  end
end
