class AddNoOfViewFromPlaylistToAd < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :view_from_playlist, :bigint, default: 0
  end
end
