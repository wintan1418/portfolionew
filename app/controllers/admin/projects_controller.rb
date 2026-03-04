module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: [ :edit, :update, :destroy ]

    def index
      @projects = Project.ordered
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        redirect_to admin_projects_path, notice: "Project created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @project.update(project_params)
        redirect_to admin_projects_path, notice: "Project updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_path, notice: "Project deleted."
    end

    def reorder
      @project = Project.find_by!(slug: params[:id])
      @project.update(position: params[:position])
      head :ok
    end

    private

    def set_project
      @project = Project.find_by!(slug: params[:id])
    end

    def project_params
      params.require(:project).permit(
        :title, :slug, :summary, :live_url, :github_url,
        :featured, :position, :completed_on, :status, :project_type,
        :cover_image, :body,
        :challenge, :solution, :results, :client_name, :client_role, :metrics,
        tech_stack: [], images: []
      )
    end
  end
end
