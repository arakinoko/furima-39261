class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
    redirect_to root_path unless @item.user == current_user
  end

  def item_params
    params.require(:item).permit(:name, :description, :status_id, :postage_id, :prefecture_id, :shopping_date_id, :price,
                                 :category_id, :image).merge(user_id: current_user.id)
  end
end
