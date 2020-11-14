class AddPublicPrivateFieldToPlaylist < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :public, :boolean, default: false
    add_column :playlists, :slug, :string

    change_column :playlists, :description, :text
  end
end
