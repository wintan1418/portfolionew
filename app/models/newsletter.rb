class Newsletter < ApplicationRecord
  # Validations
  validates :subject, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: %w[draft sent] }

  # Scopes
  scope :draft, -> { where(status: "draft") }
  scope :sent, -> { where(status: "sent") }
  scope :recent, -> { order(created_at: :desc) }

  def draft?
    status == "draft"
  end

  def sent?
    status == "sent"
  end
end
