set :application, "vote.trianglebattle.com"
set :location, "174.143.146.148"
set :user, "deploy"
set :port, 22
set :deploy_to, "/var/www/vote.trianglebattle.com"
set :deploy_via, :copy
set :copy_remote_dir, "/var/www/tmp/capistrano"
set :copy_exclude, [".git", "Capfile", "config/deploy.rb"]
set :use_sudo, false

set :scm, :git
set :repository,  "deploy@10.80.160.67:code/mckinney-battle-of-the-bands-voting.git"

namespace :remote do
  desc "Create directory required by copy_remote_dir"
  task :create_copy_dir, :roles => :app do
    run "mkdir -p #{copy_remote_dir}"
  end
end

role :web, location
role :app, location
role :db,  location, :primary => true
