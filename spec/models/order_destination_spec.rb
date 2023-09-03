require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_destination).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_destination.building_name = ''
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_destination.postal_code = '123-123４'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが「---」だと保存できないこと' do
        @order_destination.prefecture_id = '0'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'user_idが紐づいていなければ購入できないこと' do
        @order_destination.user_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていなければ購入できないこと' do
        @order_destination.item_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_destination.phone_number = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンがあると保存できないこと' do
        @order_destination.phone_number = '090-1111-2222'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上あると保存できないこと' do
        @order_destination.phone_number = '090123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが9桁以下あると保存できないこと' do
        @order_destination.phone_number = '090123456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が半角数値でないと購入できないこと' do
        @order_destination.phone_number = '０9012341234'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
