require "test_helper"

class MyoccassionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get myoccassions_new_url
    assert_response :success
  end

  test "should get create" do
    get myoccassions_create_url
    assert_response :success
  end
end
