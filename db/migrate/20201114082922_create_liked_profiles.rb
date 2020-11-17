class CreateLikedProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :liked_profiles do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
