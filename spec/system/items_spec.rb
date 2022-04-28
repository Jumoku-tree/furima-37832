require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = nil
    @image_path = Rails.root.join('public/images/test_image.png')
  end
  context '商品出品できる時' do
    it 'ログインしているユーザーは商品出品ができる' do
      enter_basic_auth(root_path)
      visit new_user_registration_path
      sign_in(@user)
      expect(current_path).to eq root_path
      expect(page).to have_content "出品する"
      visit new_item_path
      attach_file('item[image]', @image_path, make_visible: true)
      fill_in 'item-name', with: @item.title
      fill_in 'item-info', with: @item.about
      find('#item-category').find('option[value="2"]').select_option
      find('#item-sales-status').find('option[value="2"]').select_option
      find('#item-shipping-fee-status').find('option[value="2"]').select_option
      find('#item-prefecture').find('option[value="2"]').select_option
      find('#item-scheduled-delivery').find('option[value="2"]').select_option
      fill_in 'item-price', with: @item.price
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content(@item.title)
      expect(page).to have_selector("img[src$='test_image.png']")
    end

    it 'ログインしていないと新規投稿ページにアクセスできない' do
      enter_basic_auth(root_path)
      visit new_item_path
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品編集できる時' do
    it 'ログインしているユーザーは自分が出品した商品の編集ができる' do
      enter_basic_auth(root_path)
      visit new_user_registration_path
      sign_in(@item1.user)
      expect(current_path).to eq root_path
      expect(page).to have_content @item1.title
      visit item_path(@item1.id)
      expect(page).to have_content "商品の編集"
      visit edit_item_path(@item1.id)
      expect(
        find('#item-name').value
      ).to eq(@item1.title)
      expect(
        find('#item-info').value
      ).to eq(@item1.about)
      expect(
        find('#item-category').value
      ).to eq(@item1.category_id.to_s)
      expect(
        find('#item-sales-status').value
      ).to eq(@item1.condition_id.to_s)
      expect(
        find('#item-shipping-fee-status').value
      ).to eq(@item1.charge_id.to_s)
      expect(
        find('#item-prefecture').value
      ).to eq(@item1.prefecture_id.to_s)
      expect(
        find('#item-scheduled-delivery').value
      ).to eq(@item1.till_id.to_s)
      fill_in 'item-info', with: "#{@item1.about}+新しい説明！！！！"
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)      
      expect(current_path).to eq item_path(@item1.id)
      expect(page).to have_content("#{@item1.about}+新しい説明！！！！")
    end
    context '商品編集できないとき' do
      it 'ログインしていないと商品編集できない' do
        enter_basic_auth(root_path)
        visit item_path(@item1.id)
        expect(page).to have_no_content "商品の編集"
        visit item_path(@item2.id)
        expect(page).to have_no_content "商品の編集"
      end

      it 'ログインしていても自分が投稿した商品でなければ編集できない' do
        enter_basic_auth(root_path)
        sign_in(@item1.user)
        visit item_path(@item2.id)
        expect(page).to have_no_content "商品の編集"
      end

    end
  end

end

RSpec.describe "商品削除", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品削除できる時' do
    it 'ログインしているユーザーは自分が出品した商品の削除ができる' do
      enter_basic_auth(root_path)
      visit new_user_registration_path
      sign_in(@item1.user)
      expect(current_path).to eq root_path
      expect(page).to have_content @item1.title
      visit item_path(@item1.id)
      expect(page).to have_link "削除", href: item_path(@item1.id)
      expect{
        find_link('削除', href: item_path(@item1.id)).click
      }.to change { Item.count }.by(-1)      
      expect(current_path).to eq root_path
      expect(page).to have_no_content(@item1.title)
    end
    context '商品削除できないとき' do
      it 'ログインしていないと商品削除できない' do
        enter_basic_auth(root_path)
        visit item_path(@item1.id)
        expect(page).to have_no_link "削除", href: item_path(@item1.id)
        visit item_path(@item2.id)
        expect(page).to have_no_link "削除", href: item_path(@item2.id)
      end
  
      it 'ログインしていても自分が投稿した商品でなければ削除できない' do
        enter_basic_auth(root_path)
        sign_in(@item1.user)
        visit item_path(@item2.id)
        expect(page).to have_no_link "削除", href: item_path(@item2.id)

      end
  
    end
  end

end
