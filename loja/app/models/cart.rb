# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  
  has_many :items, 
           :class_name => "CartItem", 
           :dependent => :destroy

  # quantidade de itens dos produtos do carrinho
  def product_count
   self.items.inject(0) {|sum, item| sum + item.quantity}
  end

  # adiciona um produto ao carrinho
  def add_product(product)
    # inicia transação
    transaction do 
      item = self.items.detect{|item| item.product == product}
      if item
        item.quantity += 1
        item.save
      else
        self.items.create(:product => product, :quantity => 1, :price => product.price)
      end
    end
  end

  def remove_product(product)
    transaction do
    item = self.items.detect {|item| item.product == product}
      if item
        if item.quantity > 1
          item.quantity -= 1
          item.save
        else
          self.items.delete(item)
        end
      end
    end
  end

  def total
=begin
    total = 0
    self.items.each do |item|
      total += item.total
    end
    total
=end
    self.items.inject(0) {|sum, item| sum + item.total}
  end

end
