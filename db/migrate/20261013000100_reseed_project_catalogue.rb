# Re-applies the committed project catalogue (tenant_kit copy, NaijaHomes
# retired). Idempotent; runs at deploy time because the host has no shell access.
class ReseedProjectCatalogue < ActiveRecord::Migration[8.1]
  def up
    ActiveRecord::Base.connection.schema_cache.clear!
    Project.reset_column_information
    load Rails.root.join("db/seeds/projects.rb")
  rescue StandardError => e
    say "Content seed skipped: #{e.class}: #{e.message}", true
  end

  def down; end
end
