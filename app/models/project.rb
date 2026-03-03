class Project < ApplicationRecord
  include HasCoverImage

  # Attachments
  has_one_attached :cover_image
  has_many_attached :images

  # Rich Text
  has_rich_text :body

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Callbacks
  before_validation :generate_slug

  # Scopes
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }
  scope :published, -> { where(status: %w[completed active]) }

  # URL param
  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end
end
