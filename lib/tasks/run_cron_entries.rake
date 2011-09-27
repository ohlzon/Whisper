desc "Run all cronentries"
task :run_cron_entries => :environment do
  puts "Running rake task"
  Event.due_for_running.each(&:run!)
end