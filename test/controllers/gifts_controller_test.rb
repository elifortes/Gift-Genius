require "test_helper"

class GiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get gifts_create_url
    assert_response :success
  end
end
