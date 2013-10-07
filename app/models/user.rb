class User < ActiveRecord::Base
  attr_accessible :email, :password_hash, :username, :session_token
end
