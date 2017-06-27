class User < ActiveRecord::Base

  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  # has_many :posts
  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Sub

  has_many :posts, dependent: :destroy,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post


    has_many :comments,
      primary_key: :id,
      foreign_key: :author_id,
      class_name: :Comment

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  def self.find_by_credentials(user, pass)
    @user = User.find_by(username: user)
    return nil unless @user
    @user.is_password?(pass) ? @user : nil
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end
end
