require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @published = posts(:published_post)
    @draft = posts(:draft_post)
  end

  # Validations
  test "valid post" do
    assert @published.valid?
  end

  test "requires title" do
    @published.title = nil
    assert_not @published.valid?
    assert_includes @published.errors[:title], "can't be blank"
  end

  test "requires slug" do
    post = Post.new(title: "Test", slug: nil)
    # generate_slug callback should fill it in
    post.valid?
    assert post.slug.present?
  end

  test "slug must be unique" do
    duplicate = Post.new(title: "Another", slug: @published.slug)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:slug], "has already been taken"
  end

  # Callbacks
  test "generate_slug from title when slug is blank" do
    post = Post.new(title: "My Awesome Post")
    post.valid?
    assert_equal "my-awesome-post", post.slug
  end

  test "does not overwrite existing slug" do
    post = Post.new(title: "My Post", slug: "custom-slug")
    post.valid?
    assert_equal "custom-slug", post.slug
  end

  # Scopes
  test "published scope returns only published posts with past published_at" do
    published = Post.published
    assert_includes published, @published
    assert_not_includes published, @draft
  end

  test "drafts scope returns only draft posts" do
    drafts = Post.drafts
    assert_includes drafts, @draft
    assert_not_includes drafts, @published
  end

  test "featured scope returns only featured posts" do
    featured = Post.featured
    assert_includes featured, @published
    assert_not_includes featured, @draft
  end

  test "recent scope returns published posts ordered by published_at desc" do
    recent = Post.recent
    assert_includes recent, @published
    assert_not_includes recent, @draft
  end

  # Association
  test "belongs to category" do
    assert_equal categories(:rails), @published.category
  end

  test "category is optional" do
    @published.category = nil
    assert @published.valid?
  end
end
