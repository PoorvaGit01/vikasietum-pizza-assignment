class Pizza < ApplicationRecord
  belongs_to :category
  has_many :orders, dependent: :destroy
end
