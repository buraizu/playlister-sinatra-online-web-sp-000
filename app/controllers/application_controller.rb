class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.genres = []
    song.artist = Artist.find_or_create_by(:name => params[:artist_name])
    genre = Genre.find_by_name(params[:song][:genres])
    song.genres << genre
    song.save
    redirect "songs/#{song.slug}"
  end

end
