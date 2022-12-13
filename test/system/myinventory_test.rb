require "application_system_test_case"

class MyinventoryTest< ApplicationSystemTestCase
    setup do
        @item = items(:one)
        @market1=markets(:one)
        @market2=markets(:two)
        @market3=markets(:three)
        @admin=users(:one)
        @seller=users(:two)
        @buyer=users(:three)
        visit '/login'
        fill_in "email", with: @seller.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "show all" do
        visit '/main'
        click_on "Go To Inventory"
        assert_selector "td" ,text: @market3.id
        assert_selector "td" ,text: @market3.item.name
        assert_selector "td" ,text: @market3.item.category
        assert_selector "td" ,text: @market3.price
        assert_selector "td", text: @market3.stock
      end
      test "add item" do
        click_on "Go To Inventory"
        assert_selector "p", text: "My Inventory"
        click_on "Add Item"
        fill_in "item_name", with: "M"
        fill_in "item_category",with: "robot"
        fill_in "price" ,with: 25.5
        fill_in "stock" ,with: 20
        click_on "Add Item"
        assert_selector "p", text: "Add Item Successfully"
        
        assert_selector "td" ,text: "M"
        assert_selector "td" ,text: "robot"
        assert_selector "td" ,text: "25.5"
        assert_selector "td", text: "20"

        click_on "Back To Main"
        click_on "Log Out"
        
        fill_in "email", with: @buyer.email
        fill_in "password", with: "123"
        click_on "OK"

        click_on "Go To Market"
        assert_selector "td" ,text: "M"
        assert_selector "td" ,text: "robot"
        assert_selector "td" ,text: "seller"
        assert_selector "td" ,text: "25.5"
        assert_selector "td", text: "20"
      end
      test "delete" do
        click_on "Go To Inventory"
        select(113629430,from:'market3')
        click_on "Delete"
        assert_selector "p",text:"Delete Succesfully"
        assert_no_selector "td" ,text: @market3.id
        assert_no_selector "td" ,text: @market3.item.name
        assert_no_selector "td" ,text: @market3.item.category
        assert_no_selector "td" ,text: @market3.price
        assert_no_selector "td", text: @market3.stock
      end
      test "add item fail do not fill all information" do
        click_on "Go To Inventory"
        assert_selector "p", text: "My Inventory"
        click_on "Add Item"
        fill_in "item_name", with: "M"
        click_on "Add Item"
        assert_selector "p", text: "Please fill all information"
      end
      test "add stock" do
        click_on "Go To Inventory"
        select(113629430,from:'market1')
        click_on "Add Stock"
        assert_selector "p", text: "Add Stock"
        fill_in "addStock", with: 10
        click_on "Add"
        assert_selector "td" ,text: "17"
        assert_selector "p" ,text: "Add Stock Successfully"
      end
      test "reduce stock fail" do
        click_on "Go To Inventory"
        select(113629430,from:'market2')
        click_on "Reduce Stock"
        assert_selector "p", text: "Reduce Stock"
        fill_in "reduceStock", with: 10
        click_on "Reduce"
        assert_selector "p" ,text: "Item stock cannot be negative"
      end
      test "reduce stock success" do
        click_on "Go To Inventory"
        select(113629430,from:'market2')
        click_on "Reduce Stock"
        assert_selector "p", text: "Reduce Stock"
        fill_in "reduceStock", with: 5
        click_on "Reduce"
        assert_selector "td" ,text: "2"
        assert_selector "p" ,text: "Reduce Stock Successfully"
      end
end
