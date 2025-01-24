class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.references :pizza, null: false, foreign_key: true
      t.references :crust, null: false, foreign_key: true
      t.integer :quantity, null:false
      t.integer :status, default: 0
      t.integer :price
      t.string :size

      t.timestamps
    end
  end
end
