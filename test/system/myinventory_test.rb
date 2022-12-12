require "application_system_test_case"

class MyinventoryTest< ApplicationSystemTestCase
    setup do
        @item = items(:one)
        @market=markets(:one)
        @seller=users(:two)
        @buyer=users(:three)
        visit '/login'
        fill_in "email", with: @seller.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "add item" do
        click_on "Go To Inventory"
        assert_selector "p", text: "My Inventory"
        click_on "Add Item"
        fill_in "item_name", with: @item.name
        fill_in "item_category",with: @item.category
        fill_in "price" ,with: @market.price
        fill_in "stock" ,with: @market.stock
        click_on "Add Item"
        assert_selector "p", text: "Add Item Successfully"
      end
end
