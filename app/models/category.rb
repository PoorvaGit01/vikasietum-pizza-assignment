class Category < ApplicationRecord
    has_many :pizzas 
    has_many :toppings
end
