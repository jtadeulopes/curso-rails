class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :null => true
      t.text :description
      t.decimal :price, :scale => 2, :precision => 18
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
