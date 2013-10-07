class Artist < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :songs
  has_many :albums
  belongs_to :user
end
