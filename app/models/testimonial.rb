class Testimonial < ApplicationRecord
  # Attachments
  has_one_attached :author_avatar

  # Validations
  validates :author_name, presence: true
  validates :content, presence: true

  # Scopes
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }
end
