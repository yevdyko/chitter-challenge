require 'bcrypt'

class User
  attr_reader   :password
  attr_accessor :password_confirmation

  include DataMapper::Resource

  has n, :peeps

  property :id,       Serial
  property :name,     String, required: true
  property :username, String, required: true, unique: true,
            messages: {
                       presence:  'Username must not be blank',
                       is_unique: 'Username is already taken'
                      }
  property :email, String, required: true, format: :email_address, unique: true,
            messages: {
                       presence:  'Email must not be blank',
                       is_unique: 'Email is already taken',
                       format:    'Email has an invalid format'
                      }
  property :password_digest, Text
  validates_confirmation_of :password
  validates_uniqueness_of   :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = User.first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end
end
