class Skill < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Defaults
  attribute :proficiency, :integer, default: 80

  # Scopes
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }
  scope :by_category, ->(category) { where(category: category) }
end
