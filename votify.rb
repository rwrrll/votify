require 'sinatra'
require "sinatra/content_for"
Dir["./lib/*.rb"].each { |f| require f[0...-3] }

enable :sessions

VOTERS_REQUIRED_TO_SKIP = 4
EMAIL_REGEXP = /alliants\.com$/i

raise "You must set the G_API_CLIENT variable in .env" unless G_API_CLIENT = ENV['G_API_CLIENT']
raise "You must set the G_API_SECRET variable in .env" unless G_API_SECRET = ENV['G_API_SECRET']

@@votes = Votes.new
@@current_track = ''

get '/' do
  if authenticated?
    @votes = @@votes
    erb :home
  else
    erb :auth_prompt
  end
end

get '/auth' do
  redirect Authenticator.new(request).auth_url
end

get '/logout' do
  session[:access_token] = nil
  session[:email] = nil
  redirect '/'
end

get '/oauth2callback' do
  if params[:code]
    auth = Authenticator.new(request)
    auth.authenticate params[:code]
    session[:access_token] = auth.token
    session[:email] = auth.email
  end

  redirect '/'
end

get '/vote' do
  @@votes.cast(session[:email])
  Spotify.skip_track and @@votes.reset if @@votes.count == VOTERS_REQUIRED_TO_SKIP
  redirect '/'
end


def authenticated?
  session[:access_token] = nil if session[:email] && !session[:email].match(EMAIL_REGEXP)
  return !session[:access_token].nil?
end

Thread.new do
  @@current_track = Spotify.current_track
  loop do
    if Spotify.current_track != @@current_track
      @@votes.reset
      @@current_track = Spotify.current_track
    end
    sleep 2
  end
end
