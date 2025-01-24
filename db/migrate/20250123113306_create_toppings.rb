class CreateToppings < ActiveRecord::Migration[8.0]
  def change
    create_table :toppings do |t|
      t.string :name
      t.integer :price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
