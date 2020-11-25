class AddAttributesToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :free_download, :string
    add_column :songs, :artist_id, :integer
    add_index :songs, :artist_id
  end
end
