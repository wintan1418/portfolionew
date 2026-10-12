class CorrectEducationInstitution < ActiveRecord::Migration[8.1]
  def up
    load Rails.root.join("db/seeds/projects.rb")
  rescue StandardError => e
    say "Content seed skipped: #{e.class}: #{e.message}", true
  end

  def down; end
end
