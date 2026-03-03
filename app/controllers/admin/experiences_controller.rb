module Admin
  class ExperiencesController < BaseController
    before_action :set_experience, only: [ :edit, :update, :destroy ]

    def index
      @experiences = Experience.current_first
    end

    def new
      @experience = Experience.new
    end

    def create
      @experience = Experience.new(experience_params)
      if @experience.save
        redirect_to admin_experiences_path, notice: "Experience created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @experience.update(experience_params)
        redirect_to admin_experiences_path, notice: "Experience updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @experience.destroy
      redirect_to admin_experiences_path, notice: "Experience deleted."
    end

    private

    def set_experience
      @experience = Experience.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(
        :company, :role, :description, :location, :company_url,
        :start_date, :end_date, :current, :employment_type, :position, :company_logo
      )
    end
  end
end
