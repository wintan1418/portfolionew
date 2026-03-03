class SocialLink < ApplicationRecord
  # Validations
  validates :platform, presence: true
  validates :url, presence: true

  # Scopes
  scope :visible, -> { where(visible: true) }
  scope :ordered, -> { order(position: :asc) }
end
