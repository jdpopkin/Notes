class User < ActiveRecord::Base
  attr_accessible :username, :password, :email
  attr_reader :password

  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true
  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :comments
  has_many :notes, class_name: "Note", primary_key: :id, foreign_key: :author_id

  after_initialize :ensure_session_token

  # find all votes on songs, notes, and comments by this user and sums them.
  def score
    # ActiveRecord::Base.connection.exec_params
    votes = Vote.find_by_sql([<<-SQL, self.id, self.id, self.id])
    SELECT votes.* FROM votes
    LEFT JOIN comments ON
      votes.votable_id = comments.id AND votes.votable_type = 'Comment'
    LEFT JOIN notes ON
      votes.votable_id = comments.id AND votes.votable_type = 'Note'
    LEFT JOIN songs ON
      votes.votable_id = songs.id AND votes.votable_type = 'Song'
    WHERE
      (comments.user_id = ?) OR (notes.author_id = ?) OR (songs.user_id = ?)
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
      votes.votable_id = comments.id AND votes.votable_type = 'Note'
    LEFT JOIN songs ON
      votes.votable_id = songs.id AND votes.votable_type = 'Song'
    WHERE
      votes.created_at > ? AND ((comments.user_id = ?) OR (notes.author_id = ?) OR (songs.user_id = ?))
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