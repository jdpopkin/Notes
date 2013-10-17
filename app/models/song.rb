class Song < ActiveRecord::Base
  attr_accessible :album_id, :artist_id, :lyrics, :title, :user_id
  include ERB::Util

  validates :title, presence: true
  validates :artist_id, presence: true
  before_validation :remove_carriage_returns

  before_save :ensure_html_safe
  before_save :generate_description

  belongs_to :album
  belongs_to :artist
  belongs_to :user

  has_many :notes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  include PgSearch
  multisearchable against: [:title, :lyrics]

  def remove_carriage_returns
    self.lyrics = self.lyrics.gsub("\r", "")
  end

  # Returns the n songs with the highest scores.
  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    Song.find_by_sql([<<-SQL, cutoff, n])
      SELECT songs.*, COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score FROM songs LEFT JOIN votes ON
        (songs.id = votes.votable_id AND votes.votable_type = 'Song')
      -- WHERE votes.created_at >  OR votes.id IS NULL
      GROUP BY songs.id
      ORDER BY COALESCE (SUM(votes.value), 0) DESC LIMIT ?

    SQL
  end

  def cached_score
    attributes["cached_score"] ||= self.recent_score
  end

  def score
    self.votes.inject(0) { |sum, vote| sum += vote.value }
  end

  def recent_score
    self.votes.where("created_at > ?", 1.day.ago).inject(0) do |sum, vote|
      sum += vote.value
    end
  end

  def as_json(options = {})
    hash = super(options)
    hash["score"] = self.score
    hash
  end

  def ensure_html_safe
    self.title = h(self.title)

    self.lyrics = self.lyrics.gsub("<", "")
    self.lyrics = self.lyrics.gsub(">", "")
    self.lyrics = self.lyrics.gsub("&", "+")
  end

  def generate_description
    return if self.description

    if self.album
      self.description =
        "#{self.title} is a song on #{self.album.title} by #{self.artist.name}."
    else
      self.description =
        "#{self.title} is a song by #{self.artist.name}."
    end
  end
end
