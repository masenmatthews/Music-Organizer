require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/artist')
require('./lib/album')
require('rspec')
require('pry')

enable :sessions
artist_list = Artist.list

get('/') do
  @artist_list = Artist.list
  erb(:artist_input)
end

post('/') do
  artist = params["artist"]
  artist_val = Artist.new({:name => artist})
  artist_val.add_to_list()
  Artist.sort_list
  artist_list = Artist.list
  @artist_list = artist_list
  erb(:artist_input)
end

post('/clear') do
  Artist.clear
  redirect '/'
end

get('/artist/:artist') do
  @album_list = []
  @artist_val = params.fetch(:artist)
  session[:current_artist] = @artist_val
  this_artist = artist_list.find {|object| object.name == @artist_val}
  puts this_artist.is_a?(Artist)
  @album_list = this_artist.albums
  erb(:album_input)
end



post("/artist/albums") do
  @artist_val = session[:current_artist]
  this_artist = artist_list.find {|object| object.name == @artist_val}
  album_name = params["album"]
  puts this_artist.is_a?(Artist)
  this_artist.add_album({:album_name => album_name})
  @album_list = this_artist.albums
  erb(:album_input)
end
