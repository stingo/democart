class Ad < ApplicationRecord

belongs_to :profile
has_many :order_items

extend FriendlyId
  friendly_id :name, use: :slugged

   def should_generate_new_friendly_id?
   name_changed?
  end
end
