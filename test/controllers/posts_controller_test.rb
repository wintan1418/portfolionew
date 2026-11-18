require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = posts(:published_post)
    @draft_post = posts(:draft_post)
    @category = categories(:rails)
    @headers = { "Sec-CH-UA" => '"Chromium";v="131"' }
  end

  test "should get blog index" do
    get blog_url, headers: @headers
    assert_response :success
  end

  test "should show published post" do
    get blog_post_url(slug: @published_post.slug), headers: @headers
    assert_response :success
  end

  test "a post reads on a solid sheet, light by default, with scrollable tables" do
    @published_post.update!(content_markdown: "Intro\n\n| Layer | Tool |\n| --- | --- |\n| App | Rails |\n")
    get blog_post_url(slug: @published_post.slug), headers: @headers
    assert_response :success
    assert_select "html.light"
    assert_select "body[data-default-theme=light]"
    assert_select ".reading .reading-sheet .blog-content .table-wrap table thead th", text: "Layer"
    assert_select ".reading-foot .reading-author"
  end

  test "other pages keep the dark default" do
    get root_url, headers: @headers
    assert_select "html.dark"
  end

  test "should not show draft post" do
    get blog_post_url(slug: @draft_post.slug), headers: @headers
    assert_response :not_found
  end

  test "should filter by category" do
    get blog_category_url(slug: @category.slug), headers: @headers
    assert_response :success
  end

  test "category returns 404 for non-existent slug" do
    get blog_category_url(slug: "non-existent-category"), headers: @headers
    assert_response :not_found
  end
end
