module Admin
  class ProfilesController < BaseController
    def edit
      @profile = Profile.instance
    end

    def update
      @profile = Profile.instance

      if @profile.update(profile_params)
        redirect_to edit_admin_profile_path, notice: "Profile updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def profile_params
      params.require(:profile).permit(
        :first_name, :last_name, :headline, :bio, :about,
        :email, :phone, :location,
        :github_url, :linkedin_url, :twitter_url, :website_url,
        :available_for_hire, :availability_text,
        :meta_description, :og_title, :og_description,
        :avatar, :resume_pdf, :og_image, :about_rich
      )
    end
  end
end
