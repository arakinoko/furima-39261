class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :check_item_ownership, only: [:edit, :update]

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

  def destroy
    @item = Item.find(params[:id])
    if @item.user == current_user
      @item.destroy
    end
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def check_item_ownership
    unless @item.user == current_user
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :status_id, :postage_id, :prefecture_id, :shopping_date_id, :price,
                                 :category_id, :image).merge(user_id: current_user.id)
  end
end
