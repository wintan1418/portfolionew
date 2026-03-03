class Subscriber < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: true

  # Callbacks
  before_create :generate_token

  # Scopes
  scope :active, -> { where(status: "active") }

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end
end
