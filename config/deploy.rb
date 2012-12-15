#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#set :rvm_type, :root
#set :rvm_ruby, "ruby-1.9.3-p327"
#set :base_dir, "/home/yurry"
#set :rvm_gem_home, "#{fetch(:base_dir)}/.rvm/gems/#{fetch(:rvm_ruby)}"
#set :rvm_ruby_path, "#{fetch(:base_dir)}/.rvm/rubies/#{fetch(:rvm_ruby)}"
require "rvm/capistrano"
#set :default_environment, {
#  'RUBY_VERSION' => fetch(:rvm_ruby),
#  'GEM_HOME' => "#{fetch(:rvm_gem_home)}:#{fetch(:rvm_gem_home)}@global",
#  'BUNDLE_PATH' => fetch(:rvm_gem_home),
#  'PATH' => "#{fetch(:rvm_gem_home)}/bin:#{fetch(:rvm_gem_home)}@global/bin:#{fetch(:rvm_ruby_path)}/bin:/home/rails/.rvm/bin:$PATH;",
#}

#require 'bundler/capistrano'

set :application, "Rynda"
#set :repository,  "https://github.com/vivakalman/Rynda.git"
set :repository,  "git@github.com:vivakalman/Rynda.git"
set :scm, 'git'

set :user, 'yurry'
set :branch, "master"

set :git_shallow_clone, 1
set :use_sudo, false
set :deploy_to, "/home/yurry/Rynda/public/#{application}"
#set :deloy_via, :remote_cache
set :deploy_via, :copy
set :copy_strategy, :export
set :keep_releases, 1
set :rails_env, "production"
set :migrate_target, :latest
 
default_run_options[:pty] = true
#ssh_options[:forward_agent] = true - с этим выдаёт ошибку: Error reading response length from authentication socket

server "192.168.88.5", :web, :app, :db, :primary => true
#role :web, "192.168.88.5"                          # Your HTTP server, Apache/etc
#role :app, "192.168.88.5"                          # This may be the same as your `Web` server
#role :db,  "192.168.88.5", :primary => true # This is where Rails migrations will run

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   desc "Restart the application"
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