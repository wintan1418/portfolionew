class NewsletterMailer < ApplicationMailer
  def broadcast(newsletter, subscriber)
    @newsletter = newsletter
    @subscriber = subscriber
    @profile = Profile.instance
    @unsubscribe_url = unsubscribe_url(token: subscriber.token)
    mail(
      to: subscriber.email,
      subject: newsletter.subject
    )
  end
end
