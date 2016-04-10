require 'rubygems'
require 'sinatra'
require 'httparty'

set :public_folder, Proc.new { File.join(root, 'public') }

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'dev' and password == 'dev'
end

get '/' do
  redirect '/index.html'
end

# True if x-frame-options are set, false otherwise
get '/x-frame-options' do
  return "true" if params['url'].empty?

  begin
    # TODO: does not cover (unlikely) edge case that xrespond is in allow-from
    (!HTTParty.head(params['url']).headers['x-frame-options']).to_json
  rescue
    'maybe'.to_json
  end
end

not_found do
  halt 404, 'Page not found'
end

helpers do
end
