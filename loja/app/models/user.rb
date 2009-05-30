class User < ActiveRecord::Base

  has_and_belongs_to_many :groups
  
  validates_presence_of :login
  validates_length_of :login, :within => 2..255
  validates_format_of :login, :with => /^[a-zA-Z0-9_]+$/
  validates_length_of  :password,
                       :within => 3..255,
                       :allow_blank => true,
                       :on => :create
  validates_confirmation_of :password

  # simula um atributo (campo) virtual
  attr_accessor :password, :password_confirmation

  before_save :password_encrypt

  def password_encrypt
    return if self.password.nil? || self.password.strip == ""
    self.password_hash = User.encrypt(self.password)
  end

  # autenticação
  def self.authenticate(args = {})
    user = User.find_by_login_and_password_hash(args[:login], User.encrypt(args[:password]))
    unless user
      user = User.new(:login => args[:login])
      user.errors.add_to_base("Acess denied")
    end
    user
  end

  # encripta
  def self.encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

  # verifica se o usuario pertence ao grupo
  def belongs_to_group(group)
    self.groups.find_by_name(group)
  end

end
