class Admin::DashboardController < ApplicationController
  # uncomment this below to activate a user/password access only
  # before_filter :authorize
  http_basic_authenticate_with name: ENV['username'], password: ENV['password']


  def show
    @categories = Category.all
    @products = Product.all
  end
end
