class ItemsController < ApplicationController

  private

  def items_params
    params.require(:item).permit(:name, :description, :status_id, :postage_id, :prefecture_id, :shopping_date_id, :price, :category_id, :image).merge(user_id: current_user.id)
  end
end
