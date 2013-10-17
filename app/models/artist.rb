class Artist < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :songs, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :votes, through: :songs, source: :votes
  belongs_to :user

  validates :name, :user_id, presence: true
  include ERB::Util
  before_save :ensure_html_safe

  include PgSearch
  multisearchable against: :name

  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    Artist.find_by_sql([<<-SQL, cutoff, cutoff, n])
      SELECT artists.*, COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score FROM artists LEFT JOIN songs ON
        artists.id = songs.artist_id
      LEFT JOIN votes ON
        (votes.votable_id = songs.id AND votes.votable_type = 'Song')
      -- WHERE votes.created_at >  OR votes.id IS NULL
      GROUP BY artists.id
      ORDER BY COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) DESC LIMIT ?
    SQL
  end

  def cached_score
    self.attributes["cached_score"] ||= self.recent_score
  end

  def score
    self.votes.inject(0) { |sum, vote| sum += vote.value }
    # self.score_with_cutoff(100.years.ago)
  end

  def recent_score
    self.votes.where("votes.created_at > ?", 1.day.ago).inject(0) do |sum, vote|
      sum += vote.value
    end
    # self.score_with_cutoff(1.day.ago)
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

  def ensure_html_safe
    self.name = h(self.name)
  end
end
