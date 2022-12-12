require "application_system_test_case"

class LoginsellerTest< ApplicationSystemTestCase
    setup do
        @user = users(:two)
        visit '/login'
        fill_in "email", with: @user.email
        fill_in "password", with: "123"
        click_on "OK"
      end
    test "visiting the main" do
        visit '/main'
        assert_selector "h1", text: "Home Page"
        assert_selector "a" ,text: "Go To Profile"
        assert_no_selector "a" ,text: "Go To Purchase History"
        assert_no_selector "a" ,text: "Go To Market"
        assert_selector "a", text: "Go To Sale History"
        assert_selector "a" ,text: "Go To Inventory"
        assert_selector "a" ,text: "Go To Top Seller"
        assert_no_selector "a" ,text: "Go To User"
        assert_no_selector "a" ,text: "Go To Item"
        assert_selector "a" ,text: "Log Out"
    end
    test "clicking button profile" do
        visit '/main'
        click_on "Go To Profile"
        assert_selector "p", text: "Profile"
        assert_selector "td", text: @user.email
        assert_selector "td", text: @user.name
        assert_selector "td", text: "Seller"
    end
    test "check permission" do
        visit '/my_market'
        assert_selector "p", text: "You do not have permission to access that page"
        visit '/purchase_history'
        assert_selector "p", text: "You do not have permission to access that page"
        visit users_url
        assert_selector "p", text: "You do not have permission to access that page"
        visit items_url
        assert_selector "p", text: "You do not have permission to access that page"
    end
end
