class ProfilesController < ApplicationController
  before_action :authenticate_profile!, :except => [:index, :show]
  before_action :set_profile, only: [:show, :edit, :update]
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
       @profile = Profile.friendly.find(params[:id])
        #@profile = Profile.friendly.find_by(displayname: params[:displayname])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :about, :phone_number, :slug, :displayname )
    end
end
