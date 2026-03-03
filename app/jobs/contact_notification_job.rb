class ContactNotificationJob < ApplicationJob
  queue_as :default

  def perform(contact)
    ContactMailer.notification(contact).deliver_later
    ContactMailer.confirmation(contact).deliver_later
  end
end
