# Applies the committed project catalogue and screenshots on deploy, since the
# production host is only reachable through Hatchbox deploys. The seed is
# idempotent, so re-running it is safe.
class SeedProjectCatalogue < ActiveRecord::Migration[8.1]
  def up
    return unless table_exists?(:projects) && table_exists?(:active_storage_blobs)

    load Rails.root.join("db/seeds/projects.rb")
    GithubReposFetchJob.perform_now
  rescue StandardError => e
    Rails.logger.error("[SeedProjectCatalogue] #{e.class}: #{e.message}")
    say "Content seed skipped: #{e.message}", true
  end

  def down; end
end
