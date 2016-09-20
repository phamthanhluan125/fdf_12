class ShopsController < ApplicationController
  before_action :load_shop, only: :show

  def index
    @shops = Shop.page(params[:page]).per Settings.common.per_page
  end

  def show
    @products = @shop.products
  end

  private
  def load_shop
    @shop = Shop.find_by id: params[:id]
    unless @shop
      flash[:danger] = t "flash.danger.load_shop"
      redirect_to root_path
    end
  end
end