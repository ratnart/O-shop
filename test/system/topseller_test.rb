require "application_system_test_case"

class TopsellerTest< ApplicationSystemTestCase
    setup do
        @seller=users(:two)
        visit '/login'
        fill_in "email", with: @seller.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "sort quantity" do
        click_on "Go To Top Seller"
        select("Quantity",from:'sort')
        click_on "Filter"
        assert_selector ".name1",text:"seller"
        assert_selector ".qp1",text:"5"

        assert_selector ".name2",text:"admin"
        assert_selector ".qp2",text:"4"
      end
      test "sort income" do
        click_on "Go To Top Seller"
        select("Income",from:'sort')
        click_on "Filter"
        assert_selector ".name1",text:"admin"
        assert_selector ".qp1",text:"80.8"

        assert_selector ".name2",text:"seller"
        assert_selector ".qp2",text:"52.5"
      end
      test "sort quantity and select date" do
        click_on "Go To Top Seller"
        select("Quantity",from:'sort')
        fill_in "from" ,with: Date.today
        fill_in "to" ,with: Date.today
        click_on "Filter"
        assert_selector ".name1",text:"seller"
        assert_selector ".qp1",text:"5"

        assert_selector ".name2",text:"admin"
        assert_selector ".qp2",text:"4"

        fill_in "from" ,with: Date.yesterday
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_no_selector ".name1",text:"seller"
        assert_no_selector ".qp1",text:"5"

        assert_no_selector ".name2",text:"admin"
        assert_no_selector ".qp2",text:"4"
      end
      test "sort Income and select date" do
        click_on "Go To Top Seller"
        select("Income",from:'sort')
        fill_in "from" ,with: Date.today
        fill_in "to" ,with: Date.today
        click_on "Filter"
        assert_selector ".name1",text:"admin"
        assert_selector ".qp1",text:"80.8"

        assert_selector ".name2",text:"seller"
        assert_selector ".qp2",text:"52.5"

        select("Income",from:'sort')
        fill_in "from" ,with: Date.yesterday
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_no_selector ".name1",text:"admin"
        assert_no_selector ".qp1",text:"80.8"

        assert_no_selector ".name2",text:"seller"
        assert_no_selector ".qp2",text:"52.5"
      end
      test "Do Not Select To Day Before From Day" do
        click_on "Go To Top Seller"
        select("Quantity",from:'sort')
        fill_in "from" ,with: Date.today
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_selector "p",text:"Do Not Select To Day Before From Day"
        select("Income",from:'sort')
        fill_in "from" ,with: Date.today
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_selector "p",text:"Do Not Select To Day Before From Day"
      end
      test "Please Enter From and To Day" do
        click_on "Go To Top Seller"
        select("Quantity",from:'sort')
        fill_in "from" ,with: Date.today
        click_on "Filter"
        assert_selector "p",text:"Please Enter From and To Day"
        select("Quantity",from:'sort')
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_selector "p",text:"Please Enter From and To Day"
        select("Income",from:'sort')
        fill_in "from" ,with: Date.today
        click_on "Filter"
        assert_selector "p",text:"Please Enter From and To Day"
        select("Income",from:'sort')
        fill_in "to" ,with: Date.yesterday
        click_on "Filter"
        assert_selector "p",text:"Please Enter From and To Day"
      end
end
