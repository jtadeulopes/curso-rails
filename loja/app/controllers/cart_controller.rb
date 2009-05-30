class CartController < ApplicationController

  def index
    @cart = cart
  end

  def add_product
    cart.add_product(Product.find(params[:id]))
    if request.xhr?
      @cart = cart
      render :partial => "cart"
    else
      redirect_to :action => :index
    end
  end

  def remove_product
    cart.remove_product(Product.find(params[:id]))
    if request.xhr?
      @cart = cart
      render :partial => "cart"
    else
      redirect_to :action => :index
    end
  end

  protected
    def cart
      c = Cart.find_by_id(session[:cart_id]) || Cart.create
      session[:cart_id] = c.id
      return c
    end

end
