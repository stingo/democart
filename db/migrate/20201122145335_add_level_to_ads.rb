class AddLevelToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :priority_level, :integer, default: 2
    add_column :ads, :active, :boolean, default: true
  end
end
