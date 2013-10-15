class User < ActiveRecord::Base
  attr_accessible :username, :password, :email
  attr_reader :password

  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :comments
  has_many :notes, class_name: "Note", primary_key: :id, foreign_key: :author_id

  after_initialize :ensure_session_token

  # includes all activity
  def recent_activity(n)
    big_array = Artist.where(user_id: self.id).last(n).to_a +
                Song.includes(:artist).where(user_id: self.id).last(n).to_a +
                Note.includes(:song).where(author_id: self.id).last(n).to_a +
                Comment.includes(:commentable).where(user_id: self.id).last(n).to_a +
                Album.includes(:artist).where(user_id: self.id).last(n).to_a

    big_array.sort_by! { |obj| obj.created_at }
    big_array.last(n).reverse
  end

  # doesn't include songs, because users don't get credit for songs
  def top_activity(n)
    # get top comments, top notes, merge lists?
    big_array = Comment.top_for_user(n, self).to_a +
                Note.top_for_user(n, self).to_a
    # do this tomorrow probably
  end

  def self.top(n)
    self.top_with_cutoff(100.years.ago, n)
  end

  def self.recent_top(n)
    self.top_with_cutoff(1.day.ago, n)
  end

  def self.top_with_cutoff(cutoff, n)
    User.find_by_sql([<<-SQL, cutoff, cutoff, n])
    SELECT users.*, COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0)
      AS cached_score FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    LEFT JOIN notes ON users.id = notes.author_id
    LEFT JOIN votes ON (comments.id = votes.votable_id AND votes.votable_type = 'Comment') OR
      (notes.id = votes.votable_id AND votes.votable_type = 'Note')
    GROUP BY users.id
    ORDER BY COALESCE(SUM(CASE WHEN votes.created_at > ? THEN votes.value ELSE 0 END), 0) DESC LIMIT ?
    SQL
  end

  # find all votes on songs, notes, and comments by this user and sums them.
  def score
    # ActiveRecord::Base.connection.exec_params
    votes = Vote.find_by_sql([<<-SQL, self.id, self.id, self.id])
    SELECT votes.* FROM votes
    LEFT JOIN comments ON
      votes.votable_id = comments.id AND votes.votable_type = 'Comment'
    LEFT JOIN notes ON
      votes.votable_id = notes.id AND votes.votable_type = 'Note'
    LEFT JOIN songs ON
      votes.votable_id = songs.id AND votes.votable_type = 'Song'
    WHERE
      (comments.user_id = ?) OR (notes.author_id = ?) -- OR (songs.user_id = ?)
    SQL

    sum = 0
    votes.each do |vote|
      sum += vote.value
    end
    sum
  end

  # Same as above, but only counting votes from last 24 hours. TODO: merge?
  def recent_score
    votes = Vote.find_by_sql([<<-SQL, 1.day.ago, self.id, self.id, self.id])
    SELECT votes.* FROM votes
    LEFT JOIN comments ON
      votes.votable_id = comments.id AND votes.votable_type = 'Comment'
    LEFT JOIN notes ON
      votes.votable_id = notes.id AND votes.votable_type = 'Note'
    -- LEFT JOIN songs ON
--       votes.votable_id = songs.id AND votes.votable_type = 'Song'
    WHERE
      votes.created_at > ? AND ((comments.user_id = ?) OR (notes.author_id = ?))
     -- OR (songs.user_id = ?))
    SQL

    sum = 0
    votes.each do |vote|
      sum += vote.value
    end
    sum
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end