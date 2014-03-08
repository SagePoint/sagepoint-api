# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
<<<<<<< HEAD
set :output, "log/cron.log"
=======
# set :output, "/path/to/my/cron_log.log"
>>>>>>> 623c6ca82ee70fe3a454a9e8d7bd6b5249256d5a
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 1.day, :roles => [:nightly] do
  rake "skills:similar_past_day"
end

every 1.day, :at => '12:39 am', :roles => [:nightly]  do
  rake "metrics:daily"
end
