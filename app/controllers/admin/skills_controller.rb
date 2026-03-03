module Admin
  class SkillsController < BaseController
    before_action :set_skill, only: [ :edit, :update, :destroy ]

    def index
      @skills = Skill.ordered
    end

    def new
      @skill = Skill.new
    end

    def create
      @skill = Skill.new(skill_params)
      if @skill.save
        redirect_to admin_skills_path, notice: "Skill created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @skill.update(skill_params)
        redirect_to admin_skills_path, notice: "Skill updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @skill.destroy
      redirect_to admin_skills_path, notice: "Skill deleted."
    end

    private

    def set_skill
      @skill = Skill.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :category, :proficiency, :icon, :position, :featured)
    end
  end
end
