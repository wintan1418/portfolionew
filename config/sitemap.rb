SitemapGenerator::Sitemap.default_host = ENV.fetch("SITE_URL", "https://oluwintan.com")

SitemapGenerator::Sitemap.create do
  # Root page
  add root_path, changefreq: "weekly", priority: 1.0

  # About page
  add about_path, changefreq: "monthly", priority: 0.8

  # Projects
  add projects_path, changefreq: "weekly", priority: 0.9
  Project.ordered.find_each do |project|
    add project_path(project.slug), lastmod: project.updated_at, changefreq: "monthly", priority: 0.7
  end

  # Blog
  add blog_path, changefreq: "weekly", priority: 0.9
  Post.published.find_each do |post|
    add blog_post_path(post.slug), lastmod: post.updated_at, changefreq: "monthly", priority: 0.7
  end

  # Experience page
  add experience_path, changefreq: "monthly", priority: 0.8

  # Contact page
  add contact_path, changefreq: "yearly", priority: 0.6
end
