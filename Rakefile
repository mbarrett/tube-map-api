begin
  require "rspec/core/rake_task"

  desc "Run all specs"
  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.rspec_opts = %w[--color]
    t.pattern = 'spec/*_spec.rb'
  end
rescue LoadError
end

task :default  => :rspec