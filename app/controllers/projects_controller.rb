class ProjectsController < ApplicationController
  allow_unauthenticated_access

  def index
    projects = Project.ordered.with_attached_cover_image

    if params[:type].present?
      projects = projects.where(project_type: params[:type])
    end

    if params[:tech].present?
      projects = projects.where("? = ANY(tech_stack)", params[:tech])
    end

    @projects = projects
    @types = Project.distinct.pluck(:project_type).compact.reject(&:blank?).sort_by { |t| Project::TYPES.keys.index(t) || 99 }
    @all_tech = Project.pluck(:tech_stack).compact.flatten.reject(&:blank?).tally.sort_by { |_, n| -n }.map(&:first)
    set_meta_tags(title: "Work", description: "Selected client work, products and open source by #{current_profile.full_name}.")
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @siblings = @project.family.present? ? Project.where(family: @project.family).where.not(id: @project.id).ordered : Project.none
    @next_project = Project.where("position > ?", @project.position).ordered.first || Project.ordered.first
    @prev_project = Project.where("position < ?", @project.position).order(position: :desc).first || Project.ordered.last
    meta = {
      title: @project.title,
      description: @project.tagline.presence || @project.summary,
      og: { title: @project.title, description: @project.tagline.presence || @project.summary, type: "article" },
      twitter: { card: "summary_large_image", title: @project.title, description: @project.tagline.presence || @project.summary }
    }
    if @project.cover_image.attached?
      meta[:og][:image] = url_for(@project.cover_image)
      meta[:twitter][:image] = url_for(@project.cover_image)
    end
    set_meta_tags(meta)
  end
end
