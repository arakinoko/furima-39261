class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :status
  belongs_to :postage
  belongs_to :shopping_date
  belongs_to :category


  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
    validates :status_id
    validates :postage_id
    validates :prefecture_id
    validates :shopping_date_id
    validates :price
    validates :category_id
    validates :user_id
  end
# ジャンルの選択が「--」の時は保存不可
  with_options numericality: { other_than: 0,  message: "can't be blank"} do
    validates :category_id
    validates :prefecture_id
    validates :status_id
    validates :postage_id
    validates :shopping_date_id
  end
 

end
