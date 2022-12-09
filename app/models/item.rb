class Item < ApplicationRecord
    has_many :inventories,dependent: :destroy
    has_one_attached :picture 
end
