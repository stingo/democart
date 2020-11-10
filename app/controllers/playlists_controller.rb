class PlaylistsController < ApplicationController
  before_action :authenticate_profile!

  def index
    @playlists = current_profile.playlists
  end

  def show
    @playlist = current_profile.playlists.find params[:id]
  end

  def new
    @playlist = current_profile.playlists.new
  end

  def create
    @playlist = current_profile.playlists.new(playlist_params)
    if @playlist.save
      redirect_to profile_playlists_path(current_profile)
    else
      render 'playlists/new'
    end
  end

  def edit
    @playlist = current_profile.playlists.find params[:id]
  end

  def update
    @playlist = current_profile.playlists.find params[:id]

    if @playlist.update_attributes(playlist_params)
      redirect_to profile_playlists_path(current_profile)
    else
      render 'playlists/edit'
    end
  end

  def destroy
    @playlist = current_profile.playlists.find params[:id]

    if @playlist.delete
      redirect_to profile_playlists_path(current_profile)
    else
      redirect_to profile_playlists_path(current_profile)
    end
  end

  def add_song
    @song = Song.find params[:song_id]
    if @song.present?
      @playlist = current_profile.playlists.all
      redirect_to songs_path
    else
      redirect_to songs_path
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name, :description)
  end
end
