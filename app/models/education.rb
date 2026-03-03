class Education < ApplicationRecord
  # Validations
  validates :institution, presence: true

  # Scopes
  scope :ordered, -> { order(position: :asc) }
end
