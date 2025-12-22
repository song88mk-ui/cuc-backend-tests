require 'rake'
require 'cucumber/rake/task'
require 'dotenv'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.profile = 'default'
end

task :clean do
  sh "rm -fr ./results"
end

task :prepare do
  sh "mkdir ./results"
end

Cucumber::Rake::Task.new(:oddsfeed) do |t|
  t.profile = ['default', 'ci', 'html', 'skip_known']
  t.cucumber_opts = %w{--tags @oddsfeed}
end

Cucumber::Rake::Task.new(:platformapi) do |t|
  t.profile = ['default', 'ci', 'html', 'skip_known']
  t.cucumber_opts = %w{--tags @platformapi}
end

task :default => :cucumber
Cucumber::Rake::Task.new(:current) do |t|
  t.profile = 'current'
end

namespace :dev do

  task :platformapi => [:clean, :prepare] do |t|
    begin
      Rake::Task['platformapi'].invoke
    rescue => e
      puts "error: #{e.message}"
    ensure
      if !ENV['CI'] then
        puts "Skipping report submission"
        exit
      end

      require_relative 'utils/report'
      Report.submit("Platform API - Endpoints", "results/index.html", "C0A1QRRDSF7", 'dev')
      exit 0
    end
  end

  task :oddsfeed => [:clean, :prepare ] do |t|
    begin
      Rake::Task['oddsfeed'].invoke
    rescue => e
      puts "error: #{e.message}"
    ensure
      if !ENV['CI'] then
        puts "Skipping report submission"
        exit
      end

      require_relative 'utils/report'
      Report.submit("OddsFeed API", "results/index.html", "C0A1QRRDSF7", 'dev')
      exit 0
    end
  end

end
