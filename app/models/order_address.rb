class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id,
                :user_id,
                :post_code,
                :prefecture_id,
                :city,
                :address1,
                :address2,
                :phone_number,
                :token

  with_options presence: true do
    validates :user_id, :item_id, :city, :address1, :token

    validates :post_code,
              format: {
                with: /\A[0-9]{3}-[0-9]{4}\z/,
                message: 'is invalid. Enter it as follows (e.g. 123-4567)'
              }

    validates :phone_number,
              length: { minimum: 10, maximum: 11 },
              format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }
  end

  validates :prefecture_id,
            numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(item_id:, user_id:)
    ShippingAddress.create(
      post_code:,
      prefecture_id:,
      city:,
      address1:,
      address2:,
      phone_number:,
      order_id: order.id
    )
  end
end
