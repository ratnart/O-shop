class AddIsDeletedToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :isdeleted, :boolean
  end
end
