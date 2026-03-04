class NewsletterBroadcastJob < ApplicationJob
  queue_as :default

  def perform(newsletter)
    Subscriber.active.find_each do |subscriber|
      NewsletterMailer.broadcast(newsletter, subscriber).deliver_later
    end
  end
end
