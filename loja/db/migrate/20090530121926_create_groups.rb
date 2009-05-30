class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end
    create_table :groups_users, :id => false do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :groups_users, [:group_id, :user_id], :unique => true
  end

  def self.down
    drop_table :groups
    drop_table :groups_users
  end
end
