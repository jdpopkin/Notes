class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable, :votable_id, :votable_type

  validates :user_id, uniqueness: {scope: [:votable_id, :votable_type]}
  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  validates :value, inclusion: [-1, 1]
  validate :cannot_vote_on_own_votable

  def cannot_vote_on_own_votable
    klass = self.votable_type.constantize
    # user_id = nil
    if klass == Note
      target_user = Note.find(self.votable_id).author_id
    else
      target_user = klass.find(self.votable_id).user_id
    end

    if target_user == self.user_id
      errors[:base] << "Cannot vote on your own item"
    end
  end

  belongs_to :user
  belongs_to :votable, polymorphic: true
end
