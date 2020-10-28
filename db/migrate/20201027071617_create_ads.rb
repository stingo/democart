class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
