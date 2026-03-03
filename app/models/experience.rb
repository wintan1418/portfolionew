class Experience < ApplicationRecord
  # Attachments
  has_one_attached :company_logo

  # Validations
  validates :company, presence: true
  validates :role, presence: true
  validates :start_date, presence: true

  # Scopes
  scope :ordered, -> { order(start_date: :desc) }
  scope :current_first, -> { order(Arel.sql("end_date IS NOT NULL, end_date DESC, start_date DESC")) }
end
