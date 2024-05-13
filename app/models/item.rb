class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_state
  belongs_to :fee_responsibility
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999
              }
  end

  # ActiveHash attributes validation
  validates :category_id,
            :product_state_id,
            :fee_responsibility_id,
            :prefecture_id,
            :shipping_day_id,
            numericality: { other_than: 0, message: "can't be blank" }
end
