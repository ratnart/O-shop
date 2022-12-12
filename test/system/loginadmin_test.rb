require "application_system_test_case"

class LoginadminTest< ApplicationSystemTestCase
    setup do
        @user = users(:one)
        visit '/login'
        fill_in "email", with: @user.email
        fill_in "password", with: "123"
        click_on "OK"
      end
      test "visiting the main" do
        visit '/main'
        assert_selector "h1", text: "Home Page"
        assert_selector "a" ,text: "Go To Profile"
        assert_selector "a" ,text: "Go To Purchase History"
        assert_selector "a" ,text: "Go To Market"
        assert_selector "a", text: "Go To Sale History"
        assert_selector "a" ,text: "Go To Inventory"
        assert_selector "a" ,text: "Go To Top Seller"
        assert_selector "a" ,text: "Go To User"
        assert_selector "a" ,text: "Go To Item"
        assert_selector "a" ,text: "Log Out"
    end
    test "clicking button profile" do
        visit '/main'
        click_on "Go To Profile"
        assert_selector "p", text: "Profile"
        assert_selector "td", text: @user.email
        assert_selector "td", text: @user.name
        assert_selector "td", text: "Admin"
    end
end
