class V1::Dashboard::OrdersController < V1::BaseController
  def index
    shop_manager = ShopManager.find_by user_id: current_user.id,
      shop_id: params[:shop_id]
    if shop_manager.present? && (shop_manager.owner? || shop_manager.manager?)
      orders = Order.orders_of_shop_pending params[:shop_id]
      result = ActiveModel::Serializer::CollectionSerializer.new(orders,
        each_serializer: OrderSerializer)
      response_success t("api.success"), result
    else
      response_not_found t "api.not_found"
    end
  end
end
