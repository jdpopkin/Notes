class Song < ActiveRecord::Base
  attr_accessible :album_id, :artist_id, :lyrics, :title, :user_id
  belongs_to :album
  belongs_to :artist
  belongs_to :user
  has_many :notes
  has_many :comments, as: :commentable
end
