class AddProfileIdToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :profile_id, :integer
    add_index :ads, :profile_id
  end
end
