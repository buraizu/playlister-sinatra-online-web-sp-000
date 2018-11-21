class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])

    @song.genres.clear
    binding.pry
    genre = Genre.find_by_name(params[:song][:genre])
    @song.genres << genre

    @song.update(params[:song])

    @song.save
    redirect "songs/#{@song.slug}"

  end

end

{"_method"=>"patch",
 "song"=>{"name"=>"Get Away", "artist"=>"adfs", "genre"=>"1"},
 "slug"=>"get-away"}
