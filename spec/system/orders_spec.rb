require 'rails_helper'

RSpec.describe "商品購入", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address)
    @order_address.user_id = @user.id
    @order_address.item_id = @item.id
  end

  context '商品の購入ができるとき', do
    it 'ログインしていれば自分が出品した以外の商品の購入ができる', do
      binding.pry
      enter_basic_auth(root_path)
      sign_in(@user)
      find_link(@item.title, href: item_path(@item.id)).click
      expect(page).to have_content @item.title
      find_link('購入画面に進む', href: item_orders_path(@item.id)).click
      fill_in 'card-number', with: 4242424242424242
      fill_in 'card-exp-month', with: 5
      fill_in 'card-exp-year', with: 25
      fill_in 'card-cvc', with: 123
      fill_in 'postal-code', with: @order_address.postal_code
      find('#prefecture').find('option[value="2"]').click
      fill_in 'city', with: @order_address.municipality
      fill_in 'addresses', with: @order_address.house_number
      fill_in 'building', with: @order_address.building
      fill_in 'phone-number', with: @order_address.phone_number
      find('input[name="commit"]').click
      expect(page).to eq root_path
    end
  context '商品の購入ができないとき' do
    it 'ログインしていなかったら商品の購入はできない' do
      
    end
    it 'ログインしていても自分が出品した商品の購入はできない' do
      
    end
  end
  end
end
