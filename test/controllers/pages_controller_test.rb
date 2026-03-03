require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:default)
  end

  test "should get home" do
    get root_url, headers: { "Sec-CH-UA" => '"Chromium";v="131"' }
    assert_response :success
    assert_select "section"
  end

  test "should get about" do
    get about_url, headers: { "Sec-CH-UA" => '"Chromium";v="131"' }
    assert_response :success
  end
end
