class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    if Brand.find_by(name: params[:item][:brand_name])
      brand = Brand.find_by(name: params[:item][:brand_name])
    else
      brand = Brand.create(name: params[:item][:brand_name])
    end
    
    item = Item.new(item_params)
    item.brand_id = brand.id
    if item.save!
    else
      @item = Item.new
      render :new
    end
  end

  def show
    @items = Item.all
  end

  private
  def brand_params
    params.require(:item).permit(:brand_name)
  end
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :category_id, :brand_id, :size_id, :condition_id, :preparation_day_id, :postage_payer_id, :prefecture_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def show
  end
end
