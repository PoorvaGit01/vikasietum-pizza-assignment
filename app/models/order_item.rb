class OrderItem < ApplicationRecord
  belongs_to :orderable, polymorphic: true
  belongs_to :order
end
