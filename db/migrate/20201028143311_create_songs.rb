class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :slug
      t.integer :profile_id

      t.timestamps
    end
  end
end