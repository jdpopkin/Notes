class Song < ActiveRecord::Base
  attr_accessible :album_id, :artist_id, :lyrics, :title, :user_id

  validates :title, presence: true
  validates :artist_id, presence: true

  belongs_to :album
  belongs_to :artist
  belongs_to :user

  has_many :notes
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  # TODO: this is unnecessary. refactor bootstrap calls. cf what was done for comments
  def total_votes
    total = 0
    self.votes.each do |vote|
      total += vote.value
    end
    total
  end

  def as_json(options = {})
    hash = super(options)
    hash["total_votes"] = self.total_votes
    hash
  end
end
