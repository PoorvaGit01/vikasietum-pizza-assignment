# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

veg_category = Category.find_or_create_by(name: "Vegetarian")
non_veg_category = Category.find_or_create_by(name: "Non-Vegetarian")
base_category = Category.find_or_create_by(name:"base")
[
    {name: "Deluxe Veggie", regular_price: 150, medium_price: 200, large_price: 325,category_id: veg_category.id},

    {name: "Cheese and corn", regular_price: 175, medium_price: 375, large_price: 475,category_id: veg_category.id},

    {name: "Paneer Tikka", regular_price: 160, medium_price: 290, large_price: 340, category_id: veg_category.id},

    {name: "Non-Veg Supreme", regular_price: 190, medium_price: 325, large_price: 425, category_id: non_veg_category.id}, 

    {name: "Chicken Tikk", regular_price: 210, medium_price: 370, large_price: 500, category_id: non_veg_category.id},

    {name: "Pepper Barbecue Chicken", regular_price: 220, medium_price: 380, large_price: 525, category_id: non_veg_category.id},
].each do |pizza|
    Pizza.find_or_create_by(pizza)
end

["New hand tossed", "Wheat thin crust", "Cheese Burst", "Fresh pan pizza"].each do |crust|
    Crust.find_or_create_by(name:crust)
end


[
    {name:"Paneer", price:35, category_id:veg_category.id},
    {name:"Extra cheese", price:35, category_id:base_category.id},

    {name:"Black olive", price:20, category_id:base_category.id},
    {name:"Capsicum", price:25, category_id:base_category.id},
    {name:"Mushroom", price:30, category_id:base_category.id},
    {name:"Fresh tomato", price:10, category_id:base_category.id},

    {name:"Chicken tikka", price:35, category_id:non_veg_category.id},
    {name:"Barbeque chicken", price:45, category_id:non_veg_category.id},
    {name:"Grilled chicken", price:40, category_id:non_veg_category.id}

].each do |topping|
    Topping.find_or_create_by(topping)
end

[
    {name:"Cold drink", price:55},
    {name:"Mousse cake", price:90}

].each do |side|
    SideItem.find_or_create_by(side)
end