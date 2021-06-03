class AddDurationLimitToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :duration_limit, :integer, default: -1
  end
end
