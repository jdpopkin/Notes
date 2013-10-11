class Note < ActiveRecord::Base
  attr_accessible :author_id, :body, :end_index, :song_id, :start_index

  belongs_to :user, class_name: "User", primary_key: :id, foreign_key: :author_id
  belongs_to :song
  has_many :comments, as: :commentable
  has_many :votes, as: :votable


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
