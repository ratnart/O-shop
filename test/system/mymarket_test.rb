require "application_system_test_case"

class MymarketTest< ApplicationSystemTestCase
    setup do
        @item1 = items(:one)
        @market1=markets(:one)
        @market2=markets(:two)
        @market3=markets(:three)
        @seller=users(:two)
        @buyer=users(:three)
        visit '/login'
        fill_in "email", with: @buyer.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "show all" do
        visit '/main'
        click_on "Go To Market"
        assert_selector "td" ,text: @market1.id
        assert_selector "td" ,text: @market1.item.name
        assert_selector "td" ,text: @market1.item.category
        assert_selector "td" ,text: @market1.user.name
        assert_selector "td" ,text: @market1.price
        assert_selector "td", text: @market1.stock

        assert_selector "td" ,text: @market2.id
        assert_selector "td" ,text: @market2.item.name
        assert_selector "td" ,text: @market2.item.category
        assert_selector "td" ,text: @market2.user.name
        assert_selector "td" ,text: @market2.price
        assert_selector "td", text: @market2.stock

        assert_selector "td" ,text: @market3.id
        assert_selector "td" ,text: @market3.item.name
        assert_selector "td" ,text: @market3.item.category
        assert_selector "td" ,text: @market3.user.name
        assert_selector "td" ,text: @market3.price
        assert_selector "td", text: @market3.stock
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
      end
      test "buy and purchase history" do
        visit '/main'
        click_on "Go To Market"
        select(113629430,from:'market')
        click_on "Buy"
        assert_selector "p", text: "Buy Item"
        fill_in "quantity", with: 1
        click_on "Buy"
        assert_selector "p", text: "Purchase Successfully"
        assert_selector "td" ,text: "item3"
        assert_selector "td" ,text: "z"
        assert_selector "td" ,text: "seller"
        assert_selector "td" ,text: "5.5"
        assert_selector "td", text: "69"
        click_on "Back To Main"
        click_on "Go To Purchase History"
        assert_selector "p", text: "Purchase History"
        assert_selector "td" ,text: "1"
        assert_selector "td" ,text: "item3"
        assert_selector "td" ,text: "z"
        assert_selector "td" ,text: "seller"
        assert_selector "td" ,text: "5.5"
        assert_selector "td", text: "1"
      end
      test "buy failed" do
        visit '/main'
        click_on "Go To Market"
        select(113629430,from:'market')
        click_on "Buy"
        assert_selector "p", text: "Buy Item"
        fill_in "quantity", with: 90
        click_on "Buy"
        assert_selector "p", text: "Item out of stock"
      end
    test "category" do
        visit '/main'
        click_on "Go To Market"
        select('x', from: 'category')
        click_on "Search"
        assert_no_selector "td", text: "ab"
        assert_no_selector "td", text: "z"
        assert_selector "td", text: "x"
        select('z', from: 'category')
        click_on "Search"
        assert_no_selector "td", text: "ab"
        assert_selector "td", text: "z"
        assert_no_selector "td", text: "x"
        select('ab', from: 'category')
        click_on "Search"
        assert_selector "td", text: "ab"
        assert_no_selector "td", text: "z"
        assert_no_selector "td", text: "x"
    end
    test "sale history" do
      visit '/main'
        click_on "Go To Market"
        select(113629430,from:'market')
        click_on "Buy"
        assert_selector "p", text: "Buy Item"
        fill_in "quantity", with: 1
        click_on "Buy"
        assert_selector "p", text: "Purchase Successfully"
        click_on "Back To Main"

        click_on "Log Out"

        fill_in "email", with: @seller.email
        fill_in "password", with: "123"
        click_on "OK"

        click_on "Go To Sale History"

        assert_selector "p", text: "Sale History"
        assert_selector "td" ,text: "item3"
        assert_selector "td" ,text: "z"
        assert_selector "td" ,text: "buyer"
        assert_selector "td" ,text: "5.5"
        assert_selector "td", text: "1"

        assert_selector "p", text: "Sale History"
        assert_selector "td" ,text: "item2"
        assert_selector "td" ,text: "ab"
        assert_selector "td" ,text: "buyer"
        assert_selector "td" ,text: "10.5"
        assert_selector "td", text: "5"
        
    end
    test "check blank amount" do
      click_on "Go To Market"
      click_on "Buy"
      click_on "Buy"
      assert_selector "p", text: "Please enter the amount"
    end
end
