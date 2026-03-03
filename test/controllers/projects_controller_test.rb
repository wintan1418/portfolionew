require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:featured_project)
    @headers = { "Sec-CH-UA" => '"Chromium";v="131"' }
  end

  test "should get index" do
    get projects_url, headers: @headers
    assert_response :success
  end

  test "should get show" do
    get project_url(slug: @project.slug), headers: @headers
    assert_response :success
  end

  test "show returns 404 for non-existent slug" do
    get project_url(slug: "non-existent-project"), headers: @headers
    assert_response :not_found
  end
end
