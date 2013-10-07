class Album < ActiveRecord::Base
  attr_accessible :artist_id, :title, :user_id
  belongs_to :artist
  belongs_to :user
  has_many :songs
end
