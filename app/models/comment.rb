class Comment < ActiveRecord::Base
  attr_accessible :user_id, :body, :commentable, :commentable_id, :commentable_type

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable

  #before_save :ensure_html_safe

  def self.top_for_user(n, user)
    Comment.top_for_user_with_cutoff(100.years.ago, n, user)
  end

  def self.top_for_user_with_cutoff(cutoff, n, user)
    Comment.find_by_sql([<<-SQL, cutoff, user.id, n])
      SELECT comments.*,
        COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) AS cached_score
      FROM comments LEFT JOIN votes ON
        (comments.id = votes.votable_id AND votes.votable_type = 'Comment')
      LEFT JOIN users ON users.id = comments.user_id
      WHERE users.id = ?
      GROUP BY comments.id
      ORDER BY COALESCE(SUM(votes.value), 0) DESC LIMIT ?
    SQL
  end

  def cached_score
    attributes["cached_score"] ||= self.score
  end

  # TODO: this is unnecessary. refactor bootstrap calls. cf what was done for comments
  def score
    # add score caching
    total = 0
    self.votes.each do |vote|
      total += vote.value
    end
    total
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
    hash["score"] = self.score
    hash
  end

  def ensure_html_safe
    self.body = h(self.body)
  end
end
