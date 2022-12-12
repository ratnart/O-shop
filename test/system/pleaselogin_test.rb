require "application_system_test_case"

class PleaseloginTest < ApplicationSystemTestCase
    test "visiting the main" do
        visit '/main'
        assert_text "You must login before access that page"
        visit '/my_market'
        assert_text "You must login before access that page"
        visit '/purchase_history'
        assert_text "You must login before access that page"
        visit '/sale_history'
        assert_text "You must login before access that page"
        visit '/my_inventory'
        assert_text "You must login before access that page"
        visit '/top_seller'
        assert_text "You must login before access that page"
        visit items_url
        assert_text "You must login before access that page"
        visit users_url
        assert_text "You must login before access that page"
    end
end
