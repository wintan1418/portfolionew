class PagesController < ApplicationController
  allow_unauthenticated_access

  def home
    @profile = current_profile
    @featured_projects = Project.featured.ordered.limit(4)
    @skills = Skill.ordered.group_by(&:category)
    @testimonials = Testimonial.featured.ordered.limit(6)
    @experiences = Experience.current_first.limit(3)
    set_meta_tags(
      title: "Full-Stack Software Engineer",
      description: @profile.meta_description.presence || "Full-stack software engineer specializing in Ruby on Rails and modern web technologies.",
      og: {
        title: "#{@profile.full_name} — Full-Stack Software Engineer",
        description: @profile.og_description.presence || @profile.meta_description.presence || @profile.bio,
        type: "website",
        image: (@profile.og_image.attached? ? url_for(@profile.og_image) : nil)
      },
      twitter: {
        card: "summary_large_image",
        title: "#{@profile.full_name} — Full-Stack Software Engineer",
        description: @profile.meta_description.presence || @profile.bio
      }
    )
  end

  def about
    @profile = current_profile
    @skills = Skill.ordered.group_by(&:category)
    @educations = Education.ordered
    set_meta_tags(
      title: "About",
      description: "Learn more about #{@profile.full_name}, a full-stack software engineer with expertise in building modern web applications."
    )
  end

  def services
    @profile = Profile.instance
    set_meta_tags(
      title: "Services",
      description: "Full-stack development, AI integration, and technical consulting services by #{@profile.full_name}."
    )
  end
end
