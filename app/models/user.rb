class User < ApplicationRecord
    has_secure_password
    has_many :inventories ,dependent: :delete_all
    has_many :markets,dependent: :delete_all
    self.locking_column= :lock_version
end
