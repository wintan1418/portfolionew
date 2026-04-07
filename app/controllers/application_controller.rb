class ApplicationController < ActionController::Base
  include Authentication
  include Pagy::Backend
  include Trackable

  allow_browser versions: :modern
  before_action :set_meta_tags_from_profile

  helper_method :current_profile

  private

  def current_profile
    @current_profile ||= Profile.instance
  end

  def default_og_image_url
    "#{request.base_url}/og-default.png"
  end

  def set_meta_tags_from_profile
    profile = current_profile
    og_image = profile.og_image.attached? ? url_for(profile.og_image) : default_og_image_url
    set_meta_tags(
      description: profile.meta_description,
      og: {
        site_name: profile.full_name,
        type: "website",
        image: og_image
      },
      twitter: {
        card: "summary_large_image",
        image: og_image
      }
    )
  end
end
