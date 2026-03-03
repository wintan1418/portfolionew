require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  setup do
    @subscriber = subscribers(:active_subscriber)
  end

  # Validations
  test "valid subscriber" do
    assert @subscriber.valid?
  end

  test "requires email" do
    @subscriber.email = nil
    assert_not @subscriber.valid?
    assert_includes @subscriber.errors[:email], "can't be blank"
  end

  test "email must be unique" do
    duplicate = Subscriber.new(email: @subscriber.email, token: "unique_token")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  # Callbacks
  test "generate_token on create" do
    subscriber = Subscriber.create!(email: "new@test.com", name: "New")
    assert subscriber.token.present?
    assert_not_equal "test_token_123", subscriber.token
  end

  # Scopes
  test "active scope returns only active subscribers" do
    active = Subscriber.active
    assert_includes active, subscribers(:active_subscriber)
    assert_not_includes active, subscribers(:unsubscribed)
  end
end
