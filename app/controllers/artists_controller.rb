class ArtistsController < ApplicationController
  before_action :authenticate_profile!, except: [:index, :show]
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all
    @song = Song.new
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @song = Song.new
    @songs = Song.where(artist_id: @artist.id).order('number_of_play DESC')
    @total_plays = @songs.sum(:number_of_play)
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
        @artist = Artist.friendly.find(params[:id])
  end

  # POST /artists
  # POST /artists.json
  def create
      @artist = current_profile.artists.build(artist_params)

    respond_to do |format|
      if @artist.save

    if current_profile.songs.count < 1 
  
          format.html { redirect_to new_song_path, notice: 'Please add song and select Artist' }
          format.json { render :show, status: :created, location: @artist }
      else

        format.html { redirect_to @artist, notice: 'Artist was successfully created' }
        format.json { render :show, status: :created, location: @artist }
       end

      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
        @artist = Artist.friendly.find(params[:id])
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :slug, :description, :country)
    end
end

  