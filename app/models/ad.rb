class Ad < ApplicationRecord

  belongs_to :profile
  has_many :order_items

  extend FriendlyId
  friendly_id :name, use: :slugged

   def should_generate_new_friendly_id?
     name_changed?
   end

  enum priority_level: {
      High: 1,
      Medium: 2,
      Low: 3
  }
end
