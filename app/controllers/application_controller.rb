class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  patch '/songs/:slug' do
    params[:song][:genre].each do |genre|
      @song.genres << genre 
    end
    @song = Song.find_by_slug(params[:slug])
      binding.pry
    @song.update(params[:song])

  end

end

{"_method"=>"patch",
 "song"=>{"name"=>"Get Away", "artist"=>"adfs", "genre"=>"1"},
 "slug"=>"get-away"}
