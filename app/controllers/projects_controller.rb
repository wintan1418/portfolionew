class ProjectsController < ApplicationController
  allow_unauthenticated_access

  def index
    @projects = Project.ordered
    @featured_projects = Project.featured.ordered.limit(6)
    set_meta_tags(title: "Projects")
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @next_project = Project.where("position > ?", @project.position).order(position: :asc).first
    @prev_project = Project.where("position < ?", @project.position).order(position: :desc).first
    meta = {
      title: @project.title,
      description: @project.summary,
      og: {
        title: @project.title,
        description: @project.summary,
        type: "article"
      },
      twitter: {
        card: "summary_large_image",
        title: @project.title,
        description: @project.summary
      }
    }
    if @project.cover_image.attached?
      meta[:og][:image] = url_for(@project.cover_image)
      meta[:twitter][:image] = url_for(@project.cover_image)
    end
    set_meta_tags(meta)
  end
end
