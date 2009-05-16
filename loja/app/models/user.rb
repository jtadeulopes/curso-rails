class User < ActiveRecord::Base

  validates_presence_of :login
  validates_presence_of :password

  def self.authenticate(args = {})
    user = User.find_by_login_and_password(args[:login], args[:password])
    unless user
      user = User.new(:login => args[:login])
      user.errors.add_to_base("Acess denied")
    end
    user
  end

end
