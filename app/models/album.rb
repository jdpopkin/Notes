class Album < ActiveRecord::Base
  attr_accessible :artist_id, :title, :user_id
  belongs_to :artist
  belongs_to :user
  has_many :songs

  # Returns the n highest-scoring album based on votes on songs present on these
  # albums.
  def self.top(n)
    Album.find_by_sql([<<-SQL, n])
      SELECT albums.* FROM albums JOIN songs ON
        albums.id = songs.album_id
      JOIN votes ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      GROUP BY albums.id
      ORDER BY SUM(votes.value) DESC LIMIT ?
    SQL
  end

  def self.recent_top(n)
    Album.find_by_sql([<<-SQL, 1.day.ago, n])
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
    votes = Vote.find_by_sql([<<-SQL, self.id])
      SELECT votes.* FROM votes JOIN songs ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      JOIN albums ON
        songs.album_id = albums.id
      WHERE
        albums.id = ?
    SQL

    sum = 0
    votes.each do |vote|
      sum += vote.value
    end
    sum
  end

  def recent_score
    votes = Vote.find_by_sql([<<-SQL, self.id, 1.day.ago])
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
