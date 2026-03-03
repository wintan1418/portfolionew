class ContactsController < ApplicationController
  allow_unauthenticated_access

  def new
    @contact = Contact.new
    @profile = current_profile
    set_meta_tags(title: "Contact")
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactNotificationJob.perform_later(@contact)
      redirect_to contact_thank_you_path, notice: "Thanks for reaching out! I'll get back to you soon."
    else
      @profile = current_profile
      render :new, status: :unprocessable_entity
    end
  end

  def thank_you
    set_meta_tags(title: "Thank You")
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :phone, :company, :budget_range)
  end
end
