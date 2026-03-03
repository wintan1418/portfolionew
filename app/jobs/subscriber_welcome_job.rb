class SubscriberWelcomeJob < ApplicationJob
  queue_as :default

  def perform(subscriber)
    SubscriberMailer.welcome(subscriber).deliver_later
  end
end
