class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable, :votable_id, :votable_type

  validates :user_id, uniqueness: {scope: [:votable_id, :votable_type]}
  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  validates :value, inclusion: [-1, 1]

  belongs_to :user
  belongs_to :votable, polymorphic: true
end
