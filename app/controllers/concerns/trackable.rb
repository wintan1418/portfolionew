module Trackable
  extend ActiveSupport::Concern

  included do
    after_action :track_page_view, unless: :admin_request?
  end

  private

  def track_page_view
    PageView.create(
      path: request.path,
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer: request.referrer
    )
  rescue => e
    Rails.logger.warn("PageView tracking failed: #{e.message}")
  end

  def admin_request?
    request.path.start_with?("/admin")
  end
end
