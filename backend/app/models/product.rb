class Product < ApplicationRecord
    belongs_to :category
    belongs_to :brand
    belongs_to :quality
    belongs_to :color
    belongs_to :order, optional: true
    has_many :tag
end
