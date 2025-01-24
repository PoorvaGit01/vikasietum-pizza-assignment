class Topping < ApplicationRecord
  belongs_to :category
  has_many :order_items, as: :orderable, dependent: :destroy
end
