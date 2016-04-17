require 'rubygems'
require 'rack/rewrite'

use Rack::Rewrite do
  r302 %r{.*}, 'http://app.xrespond.com$&', :if => Proc.new {|rack_env|
    ENV['RACK_ENV'] == 'production' && rack_env['SERVER_NAME'] != 'app.xrespond.com'
  }
end

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'dev' and password == 'dev'
end unless ENV['RACK_ENV'] == 'production'

require './app'
run Sinatra::Application
