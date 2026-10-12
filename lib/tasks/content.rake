namespace :content do
  desc "Upsert the project catalogue and attach committed screenshots (idempotent)"
  task projects: :environment do
    load Rails.root.join("db/seeds/projects.rb")
  end

  desc "Refresh GitHub repo and star counts on the profile"
  task github: :environment do
    GithubReposFetchJob.perform_now
    puts Profile.instance.stats.inspect
  end
end
