require "test_helper"

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @headers = { "Sec-CH-UA" => '"Chromium";v="131"' }
    @subscriber = subscribers(:active_subscriber)
  end

  test "should create subscriber with valid email" do
    assert_difference("Subscriber.count", 1) do
      post subscribe_url, params: {
        subscriber: {
          email: "newsubscriber@example.com",
          name: "New Sub"
        }
      }, headers: @headers
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "should not create subscriber with duplicate email" do
    assert_no_difference("Subscriber.count") do
      post subscribe_url, params: {
        subscriber: {
          email: @subscriber.email,
          name: "Duplicate"
        }
      }, headers: @headers
    end
    assert_redirected_to root_path
  end

  test "should unsubscribe with valid token" do
    get unsubscribe_url(token: @subscriber.token), headers: @headers
    assert_redirected_to root_path
    @subscriber.reload
    assert_equal "unsubscribed", @subscriber.status
  end

  test "should handle invalid unsubscribe token" do
    get unsubscribe_url(token: "invalid_token"), headers: @headers
    assert_redirected_to root_path
  end
end
