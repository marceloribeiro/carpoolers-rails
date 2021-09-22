# frozen_string_literal: true

lock '~> 3.11.0'

set :application,   'carpoolers'
set :repo_url,      'git@github.com:marcelorocks/carpoolers-rails.git'
set :branch,        ENV['BRANCH'] if ENV['BRANCH']
set :deploy_to,     '/home/ubuntu/carpoolers'
set :ruby_version,  '2.5.1'
set :linked_files, ['config/master.key']

namespace :deploy do

  desc 'Executes bundle'
  task :bundle do
    on roles(:app) do
      execute "source \"$HOME/.rvm/scripts/rvm\" && rvm #{fetch(:ruby_version)} do bundle install --gemfile #{File.join(release_path, 'Gemfile')}"
    end
  end

  desc 'Setup Sidekiq'
  task :sidekiq do
    on roles(:app) do
      execute "source \"$HOME/.rvm/scripts/rvm\" && rvm #{fetch(:ruby_version)} && cd #{release_path} && RAILS_ENV=#{fetch(:environment)} bundle exec sidekiq -d -l #{release_path}/log/sidekiq.log"
    end
  end

  desc 'Assets Precompile'
  task :assets do
    on roles(:app) do
      execute "source \"$HOME/.rvm/scripts/rvm\" && rvm #{fetch(:ruby_version)} && cd #{release_path} && RAILS_ENV=#{fetch(:environment)} rake assets:precompile"
    end
  end

  desc 'Restart'
  after :restart, :clear_cache do
    on roles(:app) do
      execute "mkdir -p #{release_path}/tmp && touch #{release_path}/tmp/restart.txt"
    end
  end

end

after  :deploy, 'deploy:bundle'
after  :deploy, 'deploy:sidekiq'
after  :deploy, 'deploy:assets'
after  :deploy, 'deploy:restart'
