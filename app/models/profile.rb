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

  # Headline numbers for the home page. Explicit overrides win; otherwise they
  # are derived from the data we actually have.
  def stats
    {
      years: years_experience.presence || computed_years_experience,
      projects: projects_delivered.presence || Project.count,
      repos: github_repos_count.presence || 0,
      stars: github_stars_count.presence || 0
    }
  end

  def computed_years_experience
    started = Experience.minimum(:start_date)
    return 0 unless started

    ((Date.current - started) / 365.25).floor
  end
end
