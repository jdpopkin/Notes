class Comment < ActiveRecord::Base
  attr_accessible :user_id, :body, :commentable, :commentable_id, :commentable_type

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable

  # TODO: this is unnecessary. refactor bootstrap calls. cf what was done for comments
  def score
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
end
