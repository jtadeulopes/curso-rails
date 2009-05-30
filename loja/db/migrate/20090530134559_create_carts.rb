class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.timestamps
    end
    create_table :cart_items do |t|
      t.references :cart, :null => false
      t.references :product, :null => false
      t.integer :quantity
      t.decimal :price, :precision => 18, :scale => 2
      t.timestamps
    end
    add_index :cart_items, [:cart_id, :product_id], :unique => true
  end

  def self.down
    drop_table :cart_items
    drop_table :carts
  end
end
