class Project < ApplicationRecord
  include HasCoverImage

  TYPES = {
    "client" => "Client work",
    "product" => "Products",
    "open_source" => "Open source",
    "lab" => "Lab",
    "personal" => "Personal"
  }.freeze

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
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
  scope :published, -> { where(status: %w[completed active in_progress]) }
  scope :of_type, ->(type) { where(project_type: type) }
  scope :flagship, -> { featured.where(project_type: %w[client product]) }
  scope :lab, -> { where(project_type: %w[lab personal]) }

  # URL param
  def to_param
    slug
  end

  def type_label
    TYPES[project_type] || project_type.to_s.titleize
  end

  def year
    completed_on&.year
  end

  def live?
    live_url.present?
  end

  def live_host
    return if live_url.blank?

    URI.parse(live_url).host.to_s.delete_prefix("www.")
  rescue URI::InvalidURIError
    live_url
  end

  def accent
    accent_color.presence || "#6366f1"
  end

  # Gallery images that look like phone captures (portrait) vs desktop.
  def desktop_images
    images.select { |img| !portrait?(img) }
  end

  def mobile_images
    images.select { |img| portrait?(img) }
  end

  def metrics_list
    return [] if metrics.blank?

    metrics.strip.split("\n").filter_map do |line|
      label, value = line.split(":", 2)
      next if value.blank?

      [ label.strip, value.strip ]
    end
  end

  private

  def portrait?(img)
    meta = img.blob.metadata
    return false unless meta["width"] && meta["height"]

    meta["height"].to_i > meta["width"].to_i
  end

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end
end
