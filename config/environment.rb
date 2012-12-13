# Load the rails application
require File.expand_path('../application', __FILE__)

# mailer initialization
ActionMailer::Base.delivery_method = :smtp
#This tells ActionMailer that you want to user SMTP server.
# You can also set it to be :sendmail if you are using a Unix-based operating system such as Mac OS X or Linux.
ActionMailer::Base.smtp_settings = {
   :address => "192.168.129.1",  # не подключается через require 'const': Const::STR_VALUE_DEFAULT_SMTP_SERVER,
   #:port    => 25,
   #:domain  => "fortuna.odessa.ua"
   #:authentication => :plain,
   #:user_name => "admin"
   #:password => "123"
   :enable_starttls_auto => false
}
ActionMailer::Base.content_type = "text/html"

# Initialize the rails application
Rynda::Application.initialize!
