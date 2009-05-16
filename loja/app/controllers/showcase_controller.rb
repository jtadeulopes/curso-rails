class ShowcaseController < ApplicationController
  def index
    @products = Product.for_showcase
  end
  def show
    @product = Product.find(params[:id])
  end
end
