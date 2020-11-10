class Profile < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

            has_many :ads, dependent: :destroy
            has_many :songs, dependent: :destroy
             #has_many :likes
  has_many :playlists

    def full_name
    "#{first_name} #{last_name}"
    end

    

  extend FriendlyId
  friendly_id :displayname, use: :slugged

   def should_generate_new_friendly_id?
   displayname_changed?
  end

  validates :displayname, format: { with: /\A[a-zA-Z0-9]+\z/, message: "with spaces not allowed" }, length: {minimum: 4, maximum: 50}, uniqueness: true
            validates :first_name, :presence => true, :length => { :maximum => 50 }
          validates :last_name, :presence => true, :length => { :maximum => 50 }
end
