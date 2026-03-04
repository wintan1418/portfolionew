module Admin
  class TestimonialsController < BaseController
    before_action :set_testimonial, only: [ :edit, :update, :destroy ]

    def index
      @testimonials = Testimonial.ordered
    end

    def new
      @testimonial = Testimonial.new
    end

    def create
      @testimonial = Testimonial.new(testimonial_params)
      if @testimonial.save
        redirect_to admin_testimonials_path, notice: "Testimonial created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @testimonial.update(testimonial_params)
        redirect_to admin_testimonials_path, notice: "Testimonial updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @testimonial.destroy
      redirect_to admin_testimonials_path, notice: "Testimonial deleted."
    end

    def generate_link
      @testimonial = Testimonial.create!(
        author_name: "Pending",
        content: "Pending submission",
        status: "pending"
      )
      redirect_to admin_testimonials_path, notice: "Request link: #{testimonial_request_url(token: @testimonial.token)}"
    end

    private

    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    def testimonial_params
      params.require(:testimonial).permit(:author_name, :author_title, :company, :content, :rating, :featured, :position, :relationship, :author_avatar, :status)
    end
  end
end
