class ApplicationController < ActionController::Base
  include Authentication
  include Pagy::Backend
  include Trackable

  allow_browser versions: :modern

  helper_method :current_profile

  private

  def current_profile
    @current_profile ||= Profile.instance
  end

  def set_meta_tags_from_profile
    profile = current_profile
    set_meta_tags(
      description: profile.meta_description,
      og: {
        site_name: profile.full_name,
        type: "website"
      },
      twitter: {
        card: "summary_large_image"
      }
    )
  end
end
