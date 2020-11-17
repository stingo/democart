class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.integer :profile_id
      t.string :name
      t.string :description
      t.string :image
      t.string :playlist_type

      t.timestamps
    end
  end
end
