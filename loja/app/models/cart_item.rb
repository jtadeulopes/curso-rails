# == Schema Information
#
# Table name: cart_items
#
#  id         :integer         not null, primary key
#  cart_id    :integer         not null
#  product_id :integer         not null
#  quantity   :integer
#  price      :decimal(18, 2)
#  created_at :datetime
#  updated_at :datetime
#

class CartItem < ActiveRecord::Base

  belongs_to :cart
  belongs_to :product

  def total
    self.quantity * self.price
  end

end
