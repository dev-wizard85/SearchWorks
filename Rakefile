# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task(:default).clear
task default: [:ci]

desc "Execute the test build that runs on travis"
task :ci => [:environment] do
  if Rails.env.test?
    require 'solr_wrapper'

    Rake::Task["db:migrate"].invoke
    SolrWrapper.wrap do |solr|
      FileUtils.cp File.join(__dir__, 'config', 'solr_configs', 'CJKFilterUtils-v2.1.jar'), File.join(solr.instance_dir, 'contrib')
      solr.with_collection(name: 'blacklight-core') do
        Rake::Task["searchworks:fixtures"].invoke
        Rake::Task["searchworks:spec:without-data-integration"].invoke
      end
    end
  else
    system("rake ci RAILS_ENV=test")
  end
end
desc "Execute the test build that runs on jenkins"
task :jenkins => [:environment] do
  if Rails.env.test?
    Rake::Task["searchworks:spec:data-integration"].invoke
  else
    system("rake jenkins RAILS_ENV=test")
  end
end
