class Song < ActiveRecord::Base
  attr_accessible :album_id, :artist_id, :lyrics, :title
  belongs_to :album
  belongs_to :artist
end
