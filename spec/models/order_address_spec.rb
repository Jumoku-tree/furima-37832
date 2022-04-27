require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: @item.id)
  end
  describe '注文情報の保存' do
    context '購入ができるとき' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        @order_address.valid?
        expect(@order_address).to be_valid
      end
      it '建物名の情報が空でも購入できる' do
        @order_address.building = ''
        @order_address.valid?
        expect(@order_address).to be_valid
      end
    end

    context '購入ができないとき' do
      it '郵便番号がXXX-YYYY（半角数値とハイフン）の形式でないと購入できない' do
        @order_address.postal_code = '1234444'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code must include hyphen(-)")
      end
      it '郵便番号が空では購入できない' do
        @order_address.postal_code =''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code must include hyphen(-)")
      end
      it '都道府県が空では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")        
      end
      it '市町村が空では購入できない' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number must be without hypen(-) and 10/11 characters")
      end
      it '電話番号が9桁以下では購入できない' do
        @order_address.phone_number = '12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number must be without hypen(-) and 10/11 characters")

      end
      it '電話番号が12桁より長いと購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number must be without hypen(-) and 10/11 characters")
      end
      it '電話番号にハイフンがあると購入できない' do
        @order_address.phone_number = '123-456781'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number must be without hypen(-) and 10/11 characters")
      end
      it 'トークンが空では購入できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
 end
