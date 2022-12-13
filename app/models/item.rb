class Item < ApplicationRecord
    has_many :inventories,dependent: :delete_all
    has_one_attached :picture ,dependent: :delete_all
    has_many :markets,dependent: :delete_all
    self.locking_column= :lock_version
end
