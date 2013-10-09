class Note < ActiveRecord::Base
  attr_accessible :author_id, :body, :end_index, :song_id, :start_index

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

  def as_json(options = {})
    hash = super(options)
    hash["total_votes"] = self.total_votes
    hash
  end
end
