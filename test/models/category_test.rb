require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:rails)
  end

  # Validations
  test "valid category" do
    assert @category.valid?
  end

  test "requires name" do
    @category.name = nil
    assert_not @category.valid?
    assert_includes @category.errors[:name], "can't be blank"
  end

  test "slug must be unique" do
    duplicate = Category.new(name: "Another", slug: @category.slug)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:slug], "has already been taken"
  end

  # Callbacks
  test "generate_slug from name when slug is blank" do
    category = Category.new(name: "JavaScript Frameworks")
    category.valid?
    assert_equal "javascript-frameworks", category.slug
  end

  test "does not overwrite existing slug" do
    category = Category.new(name: "Test", slug: "custom-slug")
    category.valid?
    assert_equal "custom-slug", category.slug
  end

  # Associations
  test "has many posts" do
    assert_includes @category.posts, posts(:published_post)
    assert_includes @category.posts, posts(:draft_post)
  end

  # to_param
  test "to_param returns slug" do
    assert_equal "ruby-on-rails", @category.to_param
  end
end
