class AddNameToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
    add_column :profiles, :slug, :string
    add_column :profiles, :displayname, :string

    add_index :profiles, :slug
  end
end

