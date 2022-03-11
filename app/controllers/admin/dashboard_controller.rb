class Admin::DashboardController < ApplicationController
  # uncomment this below to activate a user/password access only
  # before_filter :authorize

  def show
    @categories = Category.all
    @products = Product.all
  end
end
