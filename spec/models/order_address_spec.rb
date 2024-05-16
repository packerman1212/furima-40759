require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(
      :order_address,
      item_id: item.id,
      user_id: item.user.id
    )
    sleep 0.1
  end

  describe '商品購入' do
    context '購入できる場合' do
      it '必要な情報がすべて入力されてるとき' do
        expect(@order_address).to be_valid
      end

      it 'address2が空でも購入できる' do
        @order_address.address2 = ''
        expect(@order_address).to be_valid
      end
    end
    context '購入できない場合' do
      it 'tokenが空のとき' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'post_codeが空のとき' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeにハイフンがないとき' do
        @order_address.post_code = Faker::Number.number(digits: 7)
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'post_codeが半角数字じゃないとき' do
        @order_address.post_code = @order_address.post_code.to_s.tr('0-9', '０-９')
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefecture_idが0のとき' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空のとき' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'address1が空とき' do
        @order_address.address1 = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address1 can't be blank")
      end

      it 'phone_numberが空のとき' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが半角数字じゃないとき' do
        @order_address.phone_number = @order_address.phone_number.to_s.tr('0-9', '０-９')
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberが10桁以下のとき' do
        @order_address.phone_number = Faker::Number.number(digits: rand(8..9))
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end

      it 'phone_numberが12桁以上のとき' do
        @order_address.phone_number = Faker::Number.number(digits: rand(12..13))
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it 'item_idが紐づいてないとき' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが紐づいてないとき' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
