
set :application, "woulduprefer"
set :repository,  ""

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :deploy_to, ""
server "", :app, :web, :db, :primary => true
set :user, ""
set :scm_user, ""
set :use_sudo, false
set :deploy_via, :export
set :runner, nil

set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

namespace :deploy do
  desc "Restart mongrel"
  task :restart, :roles => :app do
     #restart_mongrel_cluster
     run "mongrel_rails cluster::restart -C #{mongrel_conf}"
  end

  desc "Start mongrel"
  task :start, :roles => :app do
     #start_mongrel_cluster
     run "mongrel_rails cluster::start -C #{mongrel_conf}"
  end

  desc "Stop mongrel"
  task :stop, :roles => :app do
     #stop_mongrel_cluster
     run "mongrel_rails cluster::stop -C #{mongrel_conf}"
  end
end

desc "Create database.yml in shared/config" 
task :after_setup do
  require 'erb'
  db_user = ""
  db_password = ""
  database_configuration = ERB.new <<-EOF
login: &login
  adapter: mysql
  host: localhost
  username: <%= db_user %>
  password: <%= db_password %>

development:
  database: <%= "#{application}_development" %>
  <<: *login

test:
  database: <%= "#{application}_test" %>
  <<: *login

production:
  database: <%= "#{application}_production" %>
  <<: *login
EOF

  run "mkdir -p #{deploy_to}/#{shared_dir}/config" 
  put database_configuration.result, "#{deploy_to}/#{shared_dir}/config/database.yml" 
end

desc "Link in the production database.yml and recreate twitter file" 
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"   
end

working_twitter = ERB.new <<-EOF
gem('twitter4r', '0.3.0')
require('twitter')

class TwitterClient 
  def post_status(status)

    Twitter::Client.configure do |conf|
      conf.application_name = ''
      conf.application_version = '1.0'
      conf.application_url = ''
    end

    client = Twitter::Client.new(:login => '',:password => '')    
    new_status = Twitter::Status.create(:text => status, :client => client )
  end
end
EOF

task :after_deploy do
  put working_twitter.result, "#{deploy_to}/current/config/initializers/twitter.rb"
end




