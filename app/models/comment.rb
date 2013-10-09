class Comment < ActiveRecord::Base
  attr_accessible :user_id, :body, :commentable, :commentable_id, :commentable_type

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable
end
