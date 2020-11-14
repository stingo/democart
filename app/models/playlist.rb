class Playlist < ApplicationRecord
  belongs_to :profile
  has_many :playlists_songs, dependent: :destroy
  has_many :liked_profiles, dependent: :destroy
  has_many :songs, through: :playlists_songs

  has_one_attached :image

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  validates :name,
            presence: true,
            uniqueness: { scope: :profile_id,
                          message: ": Already Taken" }

  def add_song_to_playlist(song_id)
    if playlists_songs.create(song_id: song_id)
      true
    else
      false
    end
    end

  def remove_song_from_playlist(song_id)
    if playlists_songs.find_by(song_id: song_id).destroy
      true
    else
      false
    end
    end

  def like_playlist(profile_id)
    if liked_profiles.create(profile_id: profile_id)
      true
    else
      false
    end
  end
end
