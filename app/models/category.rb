class Category < ApplicationRecord
  # Associations
  has_many :posts, dependent: :nullify

  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  # Scopes
  scope :ordered, -> { order(position: :asc) }

  # Callbacks
  before_validation :generate_slug

  # URL param
  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize if name.present? && slug.blank?
  end
end
