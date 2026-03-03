class Contact < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  # Scopes
  scope :unread, -> { where(status: "unread") }
  scope :by_status, ->(status) { where(status: status) }
end
