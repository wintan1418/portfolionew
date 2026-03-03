class Profile < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :resume_pdf
  has_one_attached :og_image
  has_rich_text :about_rich

  validates :first_name, :last_name, presence: true

  def self.instance
    first || create!(first_name: "Your", last_name: "Name", headline: "Developer")
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
