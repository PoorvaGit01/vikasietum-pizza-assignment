class SideItem < ApplicationRecord
    has_many :order_items, as: :orderable, dependent: :destroy
end
