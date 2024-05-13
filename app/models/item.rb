class Item < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_state
  belongs_to :fee_responsibility
  belongs_to :prefecture
  belongs_to :shipping_day
end
