class User < ActiveRecord::Base

  validates_presence_of :login
  validates_length_of :login, :within => 2..255
  validates_format_of :login, :with => /^[a-zA-Z0-9_]+$/
  validates_presence_of :password
  validates_confirmation_of :password

  # simula um atributo (campo) virtual
  attr_accessor :password, :password_confirmation

  before_save :password_encrypt

  def password_encrypt
    self.password_hash = User.encrypt(self.password)
  end

  def self.authenticate(args = {})
    user = User.find_by_login_and_password_hash(args[:login], User.encrypt(args[:password]))
    unless user
      user = User.new(:login => args[:login])
      user.errors.add_to_base("Acess denied")
    end
    user
  end

  def self.encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

end
