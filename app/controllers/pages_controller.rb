class PagesController < ApplicationController
  allow_unauthenticated_access

  def home
    @profile = current_profile
    @stats = @profile.stats
    @flagship = Project.flagship.ordered.with_attached_cover_image.limit(4)
    @more_projects = Project.featured.ordered.with_attached_cover_image.where.not(id: @flagship.map(&:id)).limit(6)
    @skills = Skill.ordered.group_by(&:category)
    @testimonials = Testimonial.featured.ordered.limit(6)
    @experiences = Experience.current_first.limit(3)
    @posts = Post.published.recent.limit(3)
    @posts_count = Post.published.count
    @clients_count = Project.where(project_type: "client").count
    @clients = (Project.where(project_type: "client").ordered.pluck(:client_name, :title).map { |c, t| c.presence || t } +
                Experience.ordered.pluck(:company)).compact_blank.uniq.reject { |n| n.casecmp?("self employed") }
    set_meta_tags(
      title: "Full-Stack Software Engineer",
      description: @profile.meta_description.presence || "Full-stack software engineer specializing in Ruby on Rails and modern web technologies.",
      og: {
        title: "#{@profile.full_name} — Full-Stack Software Engineer",
        description: @profile.og_description.presence || @profile.meta_description.presence || @profile.bio,
        type: "website",
        image: @profile.og_image.attached? ? url_for(@profile.og_image) : default_og_image_url
      },
      twitter: {
        card: "summary_large_image",
        title: "#{@profile.full_name} — Full-Stack Software Engineer",
        description: @profile.meta_description.presence || @profile.bio,
        image: @profile.og_image.attached? ? url_for(@profile.og_image) : default_og_image_url
      }
    )
  end

  def about
    @profile = current_profile
    @stats = @profile.stats
    @skills = Skill.ordered.group_by(&:category)
    @educations = Education.ordered
    @experiences = Experience.current_first.limit(3)
    set_meta_tags(
      title: "About",
      description: "Learn more about #{@profile.full_name}, a full-stack software engineer with expertise in building modern web applications."
    )
  end

  def services
    @profile = current_profile
    @examples = Project.flagship.ordered.with_attached_cover_image.limit(3)
    set_meta_tags(
      title: "Services",
      description: "Full-stack development, AI integration, and technical consulting services by #{@profile.full_name}."
    )
  end
end
