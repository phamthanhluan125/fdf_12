class FollowShopsController < ApplicationController
  before_action :load_shop, only: [:create, :destroy]

  def create
    current_user.follow @shop
    render_json t("follow_shop", shop: @shop.name), 200, @shop.followers_count
  end

  def destroy
    current_user.stop_following @shop
    render_json t("unfollow_shop", shop: @shop.name), 200, @shop.followers_count
  end

  private

  def load_shop
    @shop = Shop.find_by id: params[:shop_id]
    render_json t("can_not_load_shop"), 404, "" unless @shop
  end

  def render_json message, status, count
    respond_to do |format|
      format.json{render json: {flash: message, status: status, follow_count: count}}
    end
  end
end