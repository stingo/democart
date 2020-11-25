class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :slug
      t.string :description     
      t.string :country
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
