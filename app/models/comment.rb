class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :author_name, presence: true
  validates :body, presence: true, length: { maximum: 2000 }
  validates :author_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  scope :top_level, -> { where(parent_id: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :oldest_first, -> { order(created_at: :asc) }
end
