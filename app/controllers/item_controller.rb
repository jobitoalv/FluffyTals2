class ItemController < ApplicationController
  def page
    @products = Product.all
  end
end
