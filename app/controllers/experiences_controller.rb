class ExperiencesController < ApplicationController
  allow_unauthenticated_access

  def index
    @experiences = Experience.current_first
    @educations = Education.ordered
    set_meta_tags(title: "Experience")
  end
end
