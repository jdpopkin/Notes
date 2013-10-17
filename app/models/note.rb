class Note < ActiveRecord::Base
  attr_accessible :author_id, :body, :end_index, :song_id, :start_index

  belongs_to :user, class_name: "User", primary_key: :id, foreign_key: :author_id
  belongs_to :song
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  include ERB::Util
  before_save :ensure_html_safe

  def self.top_for_user(n, user)
    Note.top_for_user_with_cutoff(100.years.ago, n, user)
  end

  def self.top_for_user_with_cutoff(cutoff, n, user)
    Note.find_by_sql([<<-SQL, cutoff, user.id, n])
      SELECT notes.*,
        COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score
      FROM notes LEFT JOIN votes ON
        (notes.id = votes.votable_id AND votes.votable_type = 'Note')
      LEFT JOIN users ON users.id = notes.author_id
      WHERE users.id = ?
      GROUP BY notes.id
      ORDER BY COALESCE(SUM(votes.value), 0) DESC LIMIT ?
    SQL
  end

  def cached_score
    attributes["cached_score"] ||= self.score
  end

  def score
    # add score caching
    self.votes.inject(0) { |sum, vote| sum += vote.value }
    # total = 0
    #     self.votes.each do |vote|
    #       total += vote.value
    #     end
    #     total
  end

  def recent_score
    self.votes.where("created_at > ?", 1.day.ago).inject(0) do |sum, vote|
      sum += vote.value
    end

    # sum = 0
    #     self.votes.each do |vote|
    #       sum += vote.value if vote.created_at > 1.day.ago
    #     end
    #     sum
  end

  def as_json(options = {})
    hash = super(options)
    hash["score"] = self.score
    hash
  end

  def ensure_html_safe
    self.body = h(self.body)
  end
end
