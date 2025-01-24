class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.integer :regular_price
      t.integer :medium_price
      t.integer :large_price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
