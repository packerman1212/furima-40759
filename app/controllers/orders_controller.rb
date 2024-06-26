class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]
  before_action :set_public_key, only: [:index, :create]
  before_action :check_sold_out, only: :index
  before_action :move_to_index, only: :index

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def order_params
    params.require(:order_address).permit(
      :post_code,
      :prefecture_id,
      :city,
      :address1,
      :address2,
      :phone_number
    ).merge(
      item_id: params[:item_id],
      user_id: current_user.id,
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def check_sold_out
    redirect_to root_path if Order.exists?(item_id: @item.id)
  end

  def move_to_index
    redirect_to root_path if current_user == @item.user
  end
end
