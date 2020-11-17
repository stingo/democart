class LikedProfile < ApplicationRecord
  belongs_to :playlist
  belongs_to :profile
end
