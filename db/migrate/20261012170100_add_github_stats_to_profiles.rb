class AddGithubStatsToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :github_repos_count, :integer
    add_column :profiles, :github_stars_count, :integer
    add_column :profiles, :github_synced_at, :datetime
    add_column :profiles, :years_experience, :integer
    add_column :profiles, :projects_delivered, :integer
  end
end
