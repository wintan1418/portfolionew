module Admin
  class SocialLinksController < BaseController
    before_action :set_social_link, only: [ :edit, :update, :destroy ]

    def index
      @social_links = SocialLink.ordered
    end

    def new
      @social_link = SocialLink.new
    end

    def create
      @social_link = SocialLink.new(social_link_params)
      if @social_link.save
        redirect_to admin_social_links_path, notice: "Social link created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @social_link.update(social_link_params)
        redirect_to admin_social_links_path, notice: "Social link updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @social_link.destroy
      redirect_to admin_social_links_path, notice: "Social link deleted."
    end

    private

    def set_social_link
      @social_link = SocialLink.find(params[:id])
    end

    def social_link_params
      params.require(:social_link).permit(:platform, :url, :icon, :position, :visible)
    end
  end
end
