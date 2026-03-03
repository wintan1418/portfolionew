module Admin
  class EducationsController < BaseController
    before_action :set_education, only: [ :edit, :update, :destroy ]

    def index
      @educations = Education.ordered
    end

    def new
      @education = Education.new
    end

    def create
      @education = Education.new(education_params)
      if @education.save
        redirect_to admin_educations_path, notice: "Education created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @education.update(education_params)
        redirect_to admin_educations_path, notice: "Education updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @education.destroy
      redirect_to admin_educations_path, notice: "Education deleted."
    end

    private

    def set_education
      @education = Education.find(params[:id])
    end

    def education_params
      params.require(:education).permit(:institution, :degree, :field_of_study, :start_date, :end_date, :description, :position)
    end
  end
end
