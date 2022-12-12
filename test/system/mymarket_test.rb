require "application_system_test_case"

class MymarketTest< ApplicationSystemTestCase
    setup do
        @item = items(:one)
        @market=markets(:one)
        @seller=users(:two)
        @buyer=users(:three)
        visit '/login'
        fill_in "email", with: @buyer.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "check column" do
        visit '/main'
        click_on "Go To Market"
        assert_selector "p", text: "Market"
        assert_selector "th", text: "No."
        assert_selector "th", text: "Picture"
        assert_selector "th", text: "Name"
        assert_selector "th", text: "Stock"
        assert_selector "th", text: "Seller"
        assert_selector "th", text: "Price"
        assert_selector "th", text: "Category"
        assert_selector "th", text: "Select Quantity"
        assert_selector "th", text: "Buy"
      end
      test "buy" do
        visit '/main'
        click_on "Go To Market"
        fill_in "quantity113629430", with: 1.to_i
        click_on "Buy Item 1"
        assert_selector "p", text: "Purchase Successfully "
        click_on "Back To Main"
        click_on "Go To Purchase History"
        assert_selector "p", text: "Purchase History"
      end
    test "category" do
        visit '/main'
        click_on "Go To Market"
        select('x', from: 'category')
        click_on "Search"
        assert_no_selector "td", text: "xz"
        assert_no_selector "td", text: "z"
        assert_selector "td", text: "x"
    end
end
