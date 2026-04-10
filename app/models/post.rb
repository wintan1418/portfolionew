class Post < ApplicationRecord
  include HasCoverImage

  # Associations
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  # Attachments
  has_one_attached :cover_image

  # Rich Text
  has_rich_text :body

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Callbacks
  before_validation :generate_slug
  before_validation :calculate_reading_time

  # Scopes
  scope :published, -> { where(status: "published").where("published_at <= ?", Time.current) }
  scope :drafts, -> { where(status: "draft") }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { published.order(published_at: :desc) }

  # URL param
  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end

  def calculate_reading_time
    text = if content_markdown.present?
             content_markdown
           elsif body.present?
             body.to_plain_text
           end
    if text.present?
      word_count = text.split.size
      self.reading_time = (word_count / 200.0).ceil
    end
  end
end
