class Product < ApplicationRecord
    belongs_to :category
    belongs_to :brand
    belongs_to :quality
    has_many :tag
    has_one :orderd_product
    has_one :order, :through => :orderd_product
end
