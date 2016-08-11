class Product < ActiveRecord::Base
    belongs_to :price
    belongs_to :title
    belongs_to :description
    belongs_to :picture
end
