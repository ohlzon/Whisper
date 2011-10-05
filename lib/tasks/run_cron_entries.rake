desc "Run all cronentries"
task :run_cron_entries => :environment do
  Event.due_for_running.each(&:run!)
end