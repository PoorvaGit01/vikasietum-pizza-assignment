class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    belongs_to :pizza
    belongs_to :crust
    belongs_to :user
    enum :status, %i(pending ordered deliverd)
    validates_presence_of :quantity, :size
end
