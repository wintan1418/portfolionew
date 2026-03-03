require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @headers = { "Sec-CH-UA" => '"Chromium";v="131"' }
  end

  test "should get new" do
    get contact_url, headers: @headers
    assert_response :success
  end

  test "should create contact with valid params" do
    assert_difference("Contact.count", 1) do
      post contact_url, params: {
        contact: {
          name: "Test Person",
          email: "testperson@example.com",
          subject: "Inquiry",
          message: "I would like to discuss a project."
        }
      }, headers: @headers
    end
    assert_redirected_to contact_thank_you_path
  end

  test "should not create contact with invalid params" do
    assert_no_difference("Contact.count") do
      post contact_url, params: {
        contact: {
          name: "",
          email: "",
          message: ""
        }
      }, headers: @headers
    end
    assert_response :unprocessable_entity
  end
end
