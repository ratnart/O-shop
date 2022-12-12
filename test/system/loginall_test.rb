require "application_system_test_case"

class LoginallTest< ApplicationSystemTestCase
    setup do
        @user = users(:one)
        visit '/login'
        fill_in "email", with: @user.email
        fill_in "password", with: "123"
        click_on "OK"
    end
    test "login fail" do
        visit '/main'
        click_on "Log Out"
        fill_in "email", with: @user.email
        fill_in "password", with: "1234"
        click_on "OK"
        assert_selector "p", text: "Incorrect email or password"
    end
    test "change password fail same old" do
        visit '/main'
        click_on "Profile"
        click_on "Change Password"
        fill_in "Password", with: "123"
        fill_in "Re-enter password", with: "123"
        click_on "OK"
        assert_selector "p", text: "Do not use old password"
    end
    test "change password fail re-enter" do
        visit '/main'
        click_on "Profile"
        click_on "Change Password"
        fill_in "Password", with: "12345"
        fill_in "Re-enter password", with: "1234"
        click_on "OK"
        assert_selector "p", text:"Re-enter password does not match"
    end
    test "change password success" do
        visit '/main'
        click_on "Profile"
        click_on "Change Password"
        fill_in "Password", with: "12345"
        fill_in "Re-enter password", with: "12345"
        click_on "OK"
        assert_selector "p", text:"Change password successfully"
        fill_in "email", with: @user.email
        fill_in "password", with: "12345"
        click_on "OK"
        assert_selector "h1", text: "Home Page"
    end
    test "logout test" do
        visit '/main'
        click_on "Log Out"
        assert_selector "p", text: "Logout successfully"
    end
end
