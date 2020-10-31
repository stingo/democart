class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_profile!, :except => [:index, :show]



  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
    @order_item = current_ordering.order_items.new
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @order_item = current_ordering.order_items.new
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.friendly.find(params[:id])
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = current_profile.ads.build(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
     @ad = Ad.friendly.find(params[:id])
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ad_params
      params.require(:ad).permit(:name, :price, :slug, :description)
    end
end
