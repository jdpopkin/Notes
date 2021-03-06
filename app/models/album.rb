class Album < ActiveRecord::Base
  attr_accessible :artist_id, :title, :user_id
  belongs_to :artist
  belongs_to :user
  has_many :songs, order: "id ASC"
  has_many :votes, through: :songs, source: :votes

  validates :artist_id, :title, :user_id, presence: true
  include ApplicationHelper
  before_save :ensure_html_safe

  include PgSearch
  multisearchable against: :title

  # Returns the n highest-scoring album based on votes on songs present on these
  # albums.
  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    select_arr = ["albums.*, COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score", cutoff]
    select = sanitize_sql_array(select_arr)

    order_arr = ["COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) DESC", cutoff]
    order = sanitize_sql_array(order_arr)

    Album.select(select)
    .joins("LEFT JOIN songs ON albums.id = songs.album_id")
    .joins("LEFT JOIN votes ON
      (votes.votable_id = songs.id AND votes.votable_type = 'Song')")
    .group("albums.id")
    .order(order)
    .limit(n)

    # Album.find_by_sql([<<-SQL, cutoff, n])
    #   SELECT albums.*, COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score FROM albums LEFT JOIN songs ON
    #     albums.id = songs.album_id
    #   LEFT JOIN votes ON
    #     (votes.votable_id = songs.id AND votes.votable_type = 'Song')
    #   -- WHERE (votes.created_at > ) OR votes.id IS NULL
    #   GROUP BY albums.id
    #   ORDER BY COALESCE(SUM(votes.value), 0) DESC LIMIT ?
    # SQL
  end

  def cached_score
    attributes["cached_score"] ||= self.recent_score
  end

  def score
    self.votes.inject(0) { |sum, vote| sum += vote.value }
  end

  def recent_score
    self.votes.where("votes.created_at > ?", 1.day.ago).inject(0) do |sum, vote|
      sum += vote.value
    end
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

  def ensure_html_safe
    self.title = escape_html(self.title)
  end

end
