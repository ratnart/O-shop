class User < ApplicationRecord
    has_secure_password
    has_many :inventories ,dependent: :destroy
    has_many :markets,dependent: :destroy
end
