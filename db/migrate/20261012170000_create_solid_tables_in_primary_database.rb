# Hatchbox runs a single PostgreSQL database, so Solid Queue, Solid Cache and
# Solid Cable live in the primary database. `db:migrate` creates them here
# instead of relying on the separate *_schema.rb files being loaded.
class CreateSolidTablesInPrimaryDatabase < ActiveRecord::Migration[8.1]
  def up
    %w[queue cache cable].each do |name|
      schema = Rails.root.join("db/#{name}_schema.rb")
      next unless File.exist?(schema)

      marker = { "queue" => "solid_queue_jobs", "cache" => "solid_cache_entries", "cable" => "solid_cable_messages" }[name]
      next if table_exists?(marker)

      # The schema files are plain ActiveRecord::Schema definitions; evaluate
      # their body against this migration's connection.
      body = File.read(schema).sub(/\AActiveRecord::Schema\[[\d.]+\]\.define\(version: \d+\) do\n/, "").sub(/\nend\s*\z/, "")
      instance_eval(body)
    end
  end

  def down
    %w[solid_queue_recurring_executions solid_queue_scheduled_executions solid_queue_ready_executions
       solid_queue_claimed_executions solid_queue_blocked_executions solid_queue_failed_executions
       solid_queue_semaphores solid_queue_recurring_tasks solid_queue_processes solid_queue_pauses
       solid_queue_jobs solid_cache_entries solid_cable_messages].each do |t|
      drop_table t, if_exists: true
    end
  end
end
