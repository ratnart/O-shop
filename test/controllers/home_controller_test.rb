require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get home_profile_url
    assert_response :success
  end

  test "should get login" do
    get home_login_url
    assert_response :success
  end

  test "should get main" do
    get home_main_url
    assert_response :success
  end
end