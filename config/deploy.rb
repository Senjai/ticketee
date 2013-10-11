load "deploy/assets"

set :application, "ticketee"
set :repository,  "git@github.com:Senjai/ticketee.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :user, "ticketee"
set :deploy_to, "/home/ticketee/apps/#{application}"
set :use_sudo, false
set :keep_releases, 5

default_run_options[:shell] = '/bin/bash --login'

role :app, "162.243.43.198"
role :web, "162.243.43.198"
role :db,  "162.243.43.198", :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    path = File.join(current_path, 'tmp', 'restart.txt')
    run "#{try_sudo} touch #{path}"
  end
end
