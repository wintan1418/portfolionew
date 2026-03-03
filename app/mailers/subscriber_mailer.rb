class SubscriberMailer < ApplicationMailer
  def welcome(subscriber)
    @subscriber = subscriber
    @profile = Profile.instance
    @unsubscribe_url = unsubscribe_url(token: @subscriber.token)
    mail(
      to: @subscriber.email,
      subject: "Welcome! You're subscribed to #{@profile&.full_name || 'Wintan'}'s blog"
    )
  end
end
