# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "shoulda", :version => "2.10.3", :source => "http://rubygems.org"
  #config.gem "twilio", :version => "2.7.0", :source => "http://rubygems.org"
  config.time_zone = 'UTC'

  config.load_paths += %W(#{RAILS_ROOT}/app/concerns)
end
