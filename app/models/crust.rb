class Crust < ApplicationRecord
  has_many :orders, dependent: :destroy
end
