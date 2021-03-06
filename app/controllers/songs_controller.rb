class SongsController < ApplicationController
  before_action :authenticate_profile!, :except => [:index, :show, :track_no_of_play, :track_no_of_download]
  before_action :set_song, only: [:show, :edit, :update, :destroy, :track_no_of_play, :track_no_of_download]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.order('number_of_play DESC')
    @ads = Ad.active
    @ad = Ad.last
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  # GET /songs/new
  def new

    if current_profile.artists.count < 1 
    redirect_to new_artist_path, alert: 'Please Add an Artist before you can add songs.'
else
    @song = Song.new
    @artists = Artist.all.map{|c| [ c.name, c.id ] }


  end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.friendly.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = current_profile.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update

    @song = Song.friendly.find(params[:id])
    
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def track_no_of_play
    @song.number_of_play += 1
    if @song.save
      logger.info "Song: #{@song.title} Update number of play to: #{@song.number_of_play}"
    else
      logger.info "Can't update number of play"
    end
    end

  def track_no_of_download
    @song.number_of_download += 1
    if @song.save
      logger.info "Song: #{@song.title} Update number of play to: #{@song.number_of_download}"
    else
      logger.info "Can't update number of download"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :slug,:mp3_audio, :free_download, :artist_id)
    end
end
