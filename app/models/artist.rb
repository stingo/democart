class Artist < ApplicationRecord
	  belongs_to :profile
	  has_many :songs, dependent: :destroy
   extend FriendlyId
  friendly_id :name, use: :slugged

   def should_generate_new_friendly_id?
   name_changed?
  end

   def country_name
    country = self.country
    ISO3166::Country[country]
  end
  
end
