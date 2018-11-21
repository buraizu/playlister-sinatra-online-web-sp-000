class SongsController < ApplicationController



  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = Artist.find_by_id(@song.artist_id)
    @genres = @song.genres
    erb :'/songs/show'
  end

  post '/songs/new' do
    song = Song.create(name: params[:song_name])

    if Artist.find_by_name(params[:artist_name])
      song.artist = Artist.find_by_name(params[:artist_name])
    else
      artist = Artist.create(name: params[:artist_name])
      song.artist = artist
    end

    Genre.all.each do |genre|
      if params[:genres].include?(genre.id.to_s)
        song.genres << genre
      end
    end

    song.save
    redirect "songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @artists = Artist.all
    @genres = Genre.all
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    binding.pry
    @song = Song.find_by_slug(params[:slug])

  end

end
