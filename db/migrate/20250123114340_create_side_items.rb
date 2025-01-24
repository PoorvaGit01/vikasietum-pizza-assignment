class CreateSideItems < ActiveRecord::Migration[8.0]
  def change
    create_table :side_items do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
