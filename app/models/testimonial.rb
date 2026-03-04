class Testimonial < ApplicationRecord
  # Attachments
  has_one_attached :author_avatar

  # Validations
  validates :author_name, presence: true
  validates :content, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }, allow_nil: true

  # Callbacks
  before_create :generate_token

  # Scopes
  scope :featured, -> { where(featured: true).where(status: ["approved", nil]) }
  scope :ordered, -> { order(position: :asc) }
  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }

  def pending?
    status == "pending"
  end

  def approved?
    status == "approved"
  end

  def rejected?
    status == "rejected"
  end

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end
end
