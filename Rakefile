unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new :cop
  RSpec::Core::RakeTask.new :spec

  task default: [:cop, :spec]
end

require 'data_mapper'
require './app/app'

namespace :db do
  desc 'Non destructive upgrade'
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts 'Auto-upgrade complete (no data loss)'
  end

  desc 'Destructive upgrade'
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts 'Auto-migrate complete (data could have been lost)'
  end
end
