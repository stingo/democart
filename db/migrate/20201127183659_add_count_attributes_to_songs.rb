class AddCountAttributesToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :number_of_play, :bigint, default: 0
    add_column :songs, :number_of_download, :bigint, default: 0
  end
end
