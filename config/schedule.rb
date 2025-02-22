# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every '0 2 5,20 * *' do # should run at 2am on 5th and 20th day every month
  runner 'PayrollGenerationService.call'
end

# Learn more: http://github.com/javan/whenever
