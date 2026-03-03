require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:featured_project)
  end

  # Validations
  test "valid project" do
    assert @project.valid?
  end

  test "requires title" do
    @project.title = nil
    assert_not @project.valid?
    assert_includes @project.errors[:title], "can't be blank"
  end

  test "requires slug" do
    project = Project.new(title: "Test", slug: nil)
    # generate_slug callback should fill it in
    project.valid?
    assert project.slug.present?
  end

  test "slug must be unique" do
    duplicate = Project.new(title: "Another", slug: @project.slug)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:slug], "has already been taken"
  end

  # Callbacks
  test "generate_slug from title when slug is blank" do
    project = Project.new(title: "My Awesome Project")
    project.valid?
    assert_equal "my-awesome-project", project.slug
  end

  test "does not overwrite existing slug" do
    project = Project.new(title: "My Project", slug: "custom-slug")
    project.valid?
    assert_equal "custom-slug", project.slug
  end

  # Scopes
  test "published scope returns completed and active projects" do
    completed = projects(:featured_project)
    active = projects(:second_project)
    published = Project.published
    assert_includes published, completed
    assert_includes published, active
  end

  test "featured scope returns only featured projects" do
    featured = Project.featured
    assert_includes featured, projects(:featured_project)
    assert_not_includes featured, projects(:second_project)
  end

  test "ordered scope orders by position ascending" do
    ordered = Project.ordered
    assert_equal projects(:featured_project), ordered.first
    assert_equal projects(:second_project), ordered.last
  end

  # to_param
  test "to_param returns slug" do
    assert_equal "test-project", @project.to_param
  end
end
