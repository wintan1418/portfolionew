class TestimonialRequestsController < ApplicationController
  allow_unauthenticated_access

  before_action :set_testimonial

  def new
    if @testimonial.nil? || !@testimonial.pending?
      redirect_to root_path, alert: "This testimonial request is no longer available."
    end
  end

  def update
    if @testimonial.nil? || !@testimonial.pending?
      redirect_to root_path, alert: "This testimonial request is no longer available."
      return
    end

    if @testimonial.update(testimonial_request_params.merge(submitted_at: Time.current))
      redirect_to new_testimonial_request_path(token: @testimonial.token), notice: "Thank you for submitting your testimonial! It will be reviewed shortly."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find_by(token: params[:token])
  end

  def testimonial_request_params
    params.require(:testimonial).permit(:author_name, :author_title, :company, :content, :rating)
  end
end
