class Note < ActiveRecord::Base
  attr_accessible :author_id, :body, :end_index, :song_id, :start_index

  has_many :comments, as: :commentable
end
