# Fetches public gem facts from rubygems.org, cached for a day. Returns nil on
# any failure so views can simply skip the block.
class RubygemsService
  API = "https://rubygems.org/api/v1".freeze

  def self.info(name)
    return if name.blank?

    Rails.cache.fetch("rubygems/#{name}", expires_in: 24.hours) { new(name).fetch }
  end

  def initialize(name)
    @name = name
  end

  def fetch
    gem = get("gems/#{@name}.json")
    return unless gem

    {
      name: gem[:name],
      version: gem[:version],
      downloads: gem[:downloads],
      version_date: gem[:version_created_at]&.first(10),
      licenses: Array(gem[:licenses]),
      homepage: gem[:homepage_uri].presence || gem[:source_code_uri],
      info: gem[:info]
    }
  rescue StandardError => e
    Rails.logger.warn("[RubygemsService] #{e.class}: #{e.message}")
    nil
  end

  private

  def get(path)
    response = Faraday.new(url: API) { |f| f.response :json, parser_options: { symbolize_names: true } }.get(path)
    response.success? ? response.body : nil
  end
end
