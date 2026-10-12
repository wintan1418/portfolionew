class GithubService
  GITHUB_API_URL = "https://api.github.com".freeze
  CACHE_TTL = 1.hour
  MAX_PAGES = 5

  def initialize(username)
    @username = username
  end

  def fetch_repos
    cache_key = "github_repos_#{@username}"

    Rails.cache.fetch(cache_key, expires_in: CACHE_TTL) do
      fetch_repos_from_api
    end
  end

  private

  def fetch_repos_from_api
    repos = []
    (1..MAX_PAGES).each do |page|
      response = connection.get("users/#{@username}/repos", sort: "updated", per_page: 100, page: page)

      unless response.success?
        Rails.logger.error("[GithubService] Failed to fetch repos for #{@username}: #{response.status}")
        break
      end

      batch = parse_repos(response.body)
      repos.concat(batch)
      break if batch.size < 100
    end
    repos
  rescue Faraday::Error => e
    Rails.logger.error("[GithubService] Request error for #{@username}: #{e.message}")
    []
  rescue StandardError => e
    Rails.logger.error("[GithubService] Unexpected error for #{@username}: #{e.message}")
    []
  end

  def connection
    @connection ||= Faraday.new(url: GITHUB_API_URL) do |f|
      f.request :json
      f.response :json, parser_options: { symbolize_names: true }
      f.headers["Accept"] = "application/vnd.github.v3+json"
      f.headers["User-Agent"] = "RailsPortfolioApp"
      f.adapter Faraday.default_adapter
    end
  end

  def parse_repos(repos)
    repos.map do |repo|
      {
        name: repo[:name],
        description: repo[:description],
        html_url: repo[:html_url],
        stargazers_count: repo[:stargazers_count],
        forks_count: repo[:forks_count],
        language: repo[:language],
        updated_at: repo[:updated_at]
      }
    end
  end
end
