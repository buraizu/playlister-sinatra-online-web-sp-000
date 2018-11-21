class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  patch '/songs/:slug' do
  binding.pry
  song = Song.find_by_slug(params[:slug])
  song.update(params[:song])
  binding.pry
  song.artist = Artist.find_or_create_by(:name => params["artist_name"])
  song.save
  binding.pry
  flash[:message] = "Successfully updated song."
  redirect :"/songs/#{song.slug}"
end
end

{"_method"=>"patch",
 "song"=>{"name"=>"Get Away", "artist"=>"adfs", "genre"=>"1"},
 "slug"=>"get-away"}
