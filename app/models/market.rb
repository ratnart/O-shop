class Market < ApplicationRecord
  belongs_to :user
  belongs_to :item
  self.locking_column= :lock_version
end
