class Artist < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :songs
  has_many :albums
  belongs_to :user

  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    Artist.find_by_sql([<<-SQL, cutoff, n])
      SELECT artists.*, SUM(votes.value) AS cached_score FROM artists JOIN songs ON
        artists.id = songs.artist_id
      JOIN votes ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      WHERE votes.created_at > ?
      GROUP BY artists.id
      ORDER BY SUM(votes.value) DESC LIMIT ?
    SQL
  end

  def cached_score
    self.attributes["cached_score"]
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
      JOIN artists ON
        songs.artist_id = artists.id
      WHERE
        (artists.id = ? AND votes.created_at > ?)
    SQL

    sum = 0
    votes.each do |vote|
      sum += vote.value
    end
    sum
  end
end
