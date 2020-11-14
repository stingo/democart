class PlaylistsController < ApplicationController
  before_action :authenticate_profile!
  skip_before_action :authenticate_profile!, only: %i[public_playlists show_public_playlist]

  def index
    @playlists = current_profile.playlists.order(:created_at)
  end

  def show
    @playlist = current_profile.playlists.friendly.find params[:id]
    @ad = Ad.all.last
  end

  def new
    @playlist = current_profile.playlists.new
  end

  def create
    @playlist = current_profile.playlists.new(playlist_params)
    respond_to do |format|
      if @playlist.save
        get_song_info if params[:song_id].present?
        format.html {redirect_to profile_playlists_path(current_profile),
                                 notice: 'Playlist is successfully created.'}
        format.json { render :get_song_info }
        format.js   { render :get_song_info }
      else
        get_song_info if params[:song_id].present?
        format.html { render action: 'new'}
        format.json { render json:  @playlist.errors, status: :unprocessable_entity }
        format.js  { render :get_song_info }
      end
    end
  end

  def edit
    @playlist = current_profile.playlists.friendly.find params[:id]
  end

  def update
    @playlist = current_profile.playlists.friendly.find params[:id]

    if @playlist.update_attributes(playlist_params)
      redirect_to profile_playlists_path(current_profile)
    else
      render 'playlists/edit'
    end
  end

  def destroy
    @playlist = current_profile.playlists.friendly.find params[:id]

    if @playlist.destroy
      redirect_back fallback_location: root_path,
                    flash: { notice: 'Successfully destroyed' }
      # redirect_to profile_playlists_path(current_profile)
    else
      redirect_back fallback_location: root_path,
                    flash: { error: 'Operation could not be completed' }
      # redirect_to profile_playlists_path(current_profile)
    end
  end

  def add_song
    @song = Song.find params[:song_id]
    @playlist = Playlist.find(params[:playlist_id])

    respond_to do |format|
      if @playlist.add_song_to_playlist(@song.id)
        @playlists = current_profile.playlists
        format.js  { render :get_song_info }
      else
        format.html { redirect_to songs_path,
                                  alert: "This song can't be added to the playlist #{@playlist.name}!!" }
      end
    end
  end

  def remove_song
    @song = Song.find params[:song_id]
    @playlist = Playlist.find(params[:playlist_id])

    respond_to do |format|
      if @playlist.remove_song_from_playlist(@song.id)
        format.html { redirect_to profile_playlist_path(current_profile, @playlist),
                                  notice: "The song successfully removed from playlist" }
      else
        format.html { redirect_to profile_playlist_path(current_profile, @playlist),
                                  alert: "This song can't be added to the playlist #{@playlist.name}!!" }
      end
    end
  end

  def get_song_info
    @song = Song.find params[:song_id]
    @playlists = current_profile.playlists


    respond_to do |format|
      format.html
      format.js
    end
  end

  def public_playlists
    @playlists = Playlist.where(public: true)
  end

  def show_public_playlist
    @playlist = Playlist.friendly.find params[:id]
    @ad = Ad.all.last
    end

  def like_public_playlist
    @playlist = Playlist.friendly.find params[:id]

    if @playlist.like_playlist(current_profile.id) && clone(@playlist, current_profile)
      redirect_to show_public_playlist_playlist_path(@playlist),
                                notice: "The playlist successfully liked"
    else
      redirect_to show_public_playlist_playlist_path(@playlist),
                                alert: "Can't like #{@playlist.name}!!"
    end
  end


  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :public, :song_id, :image)
  end

  def clone(playlist, profile)
    new_playlist = playlist.dup
    new_playlist.name = "#{new_playlist.name} (liked)"
    new_playlist.profile_id = profile.id
    new_playlist.public = false
    return false unless new_playlist.save

    playlist.playlists_songs.each do |playlists_song|
      return false unless new_playlist.playlists_songs.create(song_id: playlists_song.song_id)
    end

    true
  end
end
