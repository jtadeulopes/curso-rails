# == Schema Information
#
# Table name: carts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "adicionar produto ao carrinho" do
    # criado um novo carrinho
    cart = Cart.create
    assert_not_nil cart

    # verifica se esta vazio
    assert_equal 0, cart.product_count
    # adiciona um produto
    cart.add_product(products(:sock))
    # verifica se o produto foi adicionado
    assert_equal 1, cart.product_count

    assert_equal 30, cart.total

    # adiciona o mesmo produto e verifica se a quantidade do produto é atualizada
    cart.add_product(products(:sock))
    assert_equal 1, cart.items.count
    assert_equal 2, cart.items.first.quantity
    assert_equal 2, cart.product_count

    assert_equal 60, cart.total

    # adiciona um novo produto e verifica se a quantidade de produtos no carrinho foi atualizada
    cart.add_product(products(:tie))
    assert_equal 2, cart.items.count
    assert_equal 3, cart.product_count

    assert_equal 110, cart.total

  end

  test "remover produtos do carrinho" do

    cart = carts(:one)

    assert_equal 2, cart.items.count # quantidade de produtos no carrinho
    assert_equal 3, cart.product_count # quantidade de itens no carrinho
    assert_equal 110, cart.total

    cart.remove_product(products(:sock))
    assert_equal 2, cart.items.count
    assert_equal 2, cart.product_count
    assert_equal 80, cart.total

    cart.remove_product(products(:tie))
    assert_equal 1, cart.items.count
    assert_equal 1, cart.product_count
    assert_equal 30, cart.total

    cart.remove_product(products(:sock))
    assert_equal 0, cart.items.count
    assert_equal 0, cart.product_count
    assert_equal 0, cart.total
    
  end

  test "total de um produto do carrinho" do
    cart = Cart.new
    item = cart.items.new(:product => products(:sock),
                   :quantity => 1,
                   :price => products(:sock).price)
    assert_equal 30, item.total

    item.quantity = 2
    assert_equal 60, item.total

    item.price = 50
    assert_equal 100, item.total

    item.quantity = 0
    assert_equal 0, item.total
  end

end
