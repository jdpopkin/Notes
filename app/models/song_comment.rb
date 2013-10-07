class SongComment < ActiveRecord::Base
  attr_accessible :author_id, :body, :parent_comment_id, :song_id
end
