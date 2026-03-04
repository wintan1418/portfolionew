class PageView < ApplicationRecord
  # Validations
  validates :path, presence: true

  # Scopes
  scope :today, -> { where(created_at: Date.current.all_day) }
  scope :this_week, -> { where(created_at: 1.week.ago..) }
  scope :this_month, -> { where(created_at: 1.month.ago..) }
end
