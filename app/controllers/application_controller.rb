class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    binding.pry
  end

end
