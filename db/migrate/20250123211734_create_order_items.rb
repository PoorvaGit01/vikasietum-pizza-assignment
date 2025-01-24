class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :orderable, polymorphic: true, null: false
      t.references :order, null: false, foreign_key: true
      t.integer :price
      t.timestamps
    end
  end
end
