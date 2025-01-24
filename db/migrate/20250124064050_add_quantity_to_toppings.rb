class AddQuantityToToppings < ActiveRecord::Migration[8.0]
  def change
    add_column :toppings, :quantity, :integer
    add_column :pizzas, :quantity, :integer
    add_column :crusts, :quantity, :integer
    add_column :side_items, :quantity, :integer
  end
end
