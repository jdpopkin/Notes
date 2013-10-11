class Album < ActiveRecord::Base
  attr_accessible :artist_id, :title, :user_id
  belongs_to :artist
  belongs_to :user
  has_many :songs

  # Returns the n highest-scoring album based on votes on songs present on these
  # albums.
  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    Album.find_by_sql([<<-SQL, cutoff, n])
      SELECT albums.* FROM albums JOIN songs ON
        albums.id = songs.album_id
      JOIN votes ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      WHERE (votes.created_at > ?)
      GROUP BY albums.id
      ORDER BY SUM(votes.value) DESC LIMIT ?
    SQL
  end

  def score
    self.score_with_cutoff(100.years.ago)
  end

  def recent_score
    self.score_with_cutoff(1.day.ago)
  end

  def score_with_cutoff(cutoff)
    votes = Vote.find_by_sql([<<-SQL, self.id, cutoff])
      SELECT votes.* FROM votes JOIN songs ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      JOIN albums ON
        songs.album_id = albums.id
      WHERE
        (albums.id = ? AND votes.created_at > ?)
    SQL

    sum = 0
    votes.each do |vote|
      sum += vote.value
    end
    sum
  end

end
