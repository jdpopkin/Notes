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

  # Should return the n songs with the highest scores.
  def self.top(n)
    Song.find_by_sql([<<-SQL, n])
    SELECT songs.* FROM songs JOIN votes ON
      (songs.id = votes.votable_id AND votes.votable_type = 'Song')
    GROUP BY songs.id
    ORDER BY SUM(votes.value) DESC LIMIT ?
    SQL
  end

  def self.recent_top(n)
    Song.find_by_sql([<<-SQL, 1.day.ago, n])
    SELECT songs.* FROM songs JOIN votes ON
      (songs.id = votes.votable_id AND votes.votable_type = 'Song')
    WHERE votes.created_at > ?
    GROUP BY songs.id
    ORDER BY SUM(votes.value) DESC LIMIT ?
    SQL
  end

  # TODO: this is unnecessary. refactor bootstrap calls. cf what was done for comments
  def total_votes
    total = 0
    self.votes.each do |vote|
      total += vote.value
    end
    total
  end

  # Alias for the above function for consistency with other models. TODO: get
  # rid of the other one; figure out what's dependent on it.
  def score
    total_votes
  end

  def recent_score
    sum = 0
    self.votes.each do |vote|
      sum += vote.value if vote.created_at > 1.day.ago
    end
    sum
  end

  def as_json(options = {})
    hash = super(options)
    hash["total_votes"] = self.total_votes
    hash
  end
end
