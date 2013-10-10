class Note < ActiveRecord::Base
  attr_accessible :author_id, :body, :end_index, :song_id, :start_index

  belongs_to :user, class_name: "User", primary_key: :id, foreign_key: :author_id
  has_many :comments, as: :commentable
  has_many :votes, as: :votable


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
