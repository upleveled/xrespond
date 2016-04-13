require 'sinatra'
require 'httparty'

set :public_folder, Proc.new { File.join(root, 'public') }

get '/' do
  redirect '/index.html'
end

not_found do
  halt 404, 'Page not found'
end

helpers do
end
