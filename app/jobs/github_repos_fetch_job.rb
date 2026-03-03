class GithubReposFetchJob < ApplicationJob
  queue_as :default

  def perform
    profile = Profile.instance

    unless profile&.github_url.present?
      Rails.logger.warn("[GithubReposFetchJob] No GitHub URL configured in profile")
      return
    end

    username = extract_username(profile.github_url)

    unless username.present?
      Rails.logger.warn("[GithubReposFetchJob] Could not extract username from: #{profile.github_url}")
      return
    end

    repos = GithubService.new(username).fetch_repos
    Rails.cache.write("github_repos", repos, expires_in: 25.hours)

    Rails.logger.info("[GithubReposFetchJob] Cached #{repos.size} repos for #{username}")
  end

  private

  def extract_username(url)
    # Handle URLs like "https://github.com/username" or "https://github.com/username/"
    uri = URI.parse(url.strip)
    path_segments = uri.path.to_s.split("/").reject(&:blank?)
    path_segments.first
  rescue URI::InvalidURIError
    # Fallback: treat the whole string as a username if it has no slashes
    url.strip.split("/").last
  end
end
