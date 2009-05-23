class AddPasswordHashToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :password_hash, :string
    
    User.all.each do |user|
      user.update_attribute(:password_hash, User.encrypt(user.password))
    end

    remove_column :users, :password
  end

  def self.down
    add_column :users, :password, :string

    User.all.each do |user|
      user.update_attribute(:password, "mudar123") 
    end
    
    remove_column :users, :password_hash
  end
end
