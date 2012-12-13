set :application, "Rynda"
#set :repository,  "ssh://git@github.com/vivakalman/Rynda.git"
set :repository,  "git@github.com:vivakalman/Rynda.git"
set :scm, 'git'

set :user, 'yurry'
set :branch, "master"

set :git_shallow_clone, 1
set :use_sudo, false
set :deploy_to, "/home/yurry/Rynda/public/#{application}"
set :deloy_via, :remote_cache
set :keep_releases, 1
set :rails_env, "production"
set :migrate_target, :latest
 
default_run_options[:pty] = true
#ssh_options[:forward_agent] = true - с этим выдаёт ошибку: Error reading response length from authentication socket

role :web, "192.168.88.5"                          # Your HTTP server, Apache/etc
role :app, "192.168.88.5"                          # This may be the same as your `Web` server
role :db,  "192.168.88.5", :primary => true # This is where Rails migrations will run

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
 
 namespace :deploy do
   desc "Recreate symlink"
   task :resymlink, :roles => :app do
     run "rm -f #{current_path} && ln -s #{release_path} #{current_path}"
   end
 end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end