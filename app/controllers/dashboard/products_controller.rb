class Dashboard::ProductsController < BaseDashboardController
  before_action :load_shop, except: :index
  before_action :load_categories, only: [:edit, :new, :update]
  before_action :load_product, except: [:index, :new]

  def new
    @product = @shop.products.new
  end

  def edit
  end

  def create
    @product = @shop.products.new product_params
    if @product.save
      flash[:success] = t "flash.success.dashboard.create_product"
      redirect_to dashboard_shop_products_path
    else
      flash[:danger] = t "flash.danger.dashboard.create_product"
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "flash.success.dashboard.edit_product"
      redirect_to dashboard_shop_products_path
    else
      flash[:danger] = t "flash.danger.dashboard.edit_product"
      render :edit
    end
  end

  private
  def load_shop
    @shop = Shop.find_by id: params[:shop_id]
    unless @shop
      flash[:danger] = t "flash.danger.dashboard.shop.not_found"
      redirect_to dashboard_shops_path
    end
  end

  def product_params
    params.require(:product).permit :id, :name, :description, :price,
      :category_id, :user_id, :image
  end

  def load_categories
    @categories = Category.all
  end

  def load_product
    @product = @shop.products.find_by id: params[:id]
    unless @product
      flash[:danger] = t "flash.danger.dashboard.product.not_found"
      redirect_to dashboard_shop_products_path
    end
  end
end