class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user

  belongs_to :prefecture
  belongs_to :status
  belongs_to :postage
  belongs_to :shopping_date
  belongs_to :category

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :status_id
    validates :postage_id
    validates :prefecture_id
    validates :shopping_date_id
    validates :category_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  # ジャンルの選択が「--」の時は保存不可
  with_options numericality: { other_than: 0, message: 'must be other than 0' } do
    validates :category_id
    validates :prefecture_id
    validates :status_id
    validates :postage_id
    validates :shopping_date_id
  end
end
