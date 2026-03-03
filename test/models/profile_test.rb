require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  setup do
    @profile = profiles(:default)
  end

  test "valid profile" do
    assert @profile.valid?
  end

  test "requires first_name" do
    @profile.first_name = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:first_name], "can't be blank"
  end

  test "requires last_name" do
    @profile.last_name = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:last_name], "can't be blank"
  end

  test "Profile.instance returns a profile" do
    profile = Profile.instance
    assert_instance_of Profile, profile
  end

  test "full_name returns first and last name" do
    assert_equal "Test User", @profile.full_name
  end
end
