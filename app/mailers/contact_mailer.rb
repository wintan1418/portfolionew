class ContactMailer < ApplicationMailer
  def notification(contact)
    @contact = contact
    @profile = Profile.instance
    mail(
      to: @profile&.email || ENV.fetch("ADMIN_EMAIL", "hello@wintan.dev"),
      subject: "New contact: #{@contact.subject.presence || 'No subject'}"
    )
  end

  def confirmation(contact)
    @contact = contact
    @profile = Profile.instance
    mail(
      to: @contact.email,
      subject: "Thanks for reaching out, #{@contact.name.split.first}!"
    )
  end
end
