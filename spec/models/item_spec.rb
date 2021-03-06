require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品の出品ができるとき' do
      it 'すべての項目が入力されていれば登録できる' do
        @item.valid?
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができないとき' do
      it '画像が添付されていなければ登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.about = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("About can't be blank")
      end
      it 'カテゴリーが空では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が空では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担が空では登録できない' do
        @item.charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge can't be blank")
      end
      it '発送元の地域が空では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が空では登録できない' do
        @item.till_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Till can't be blank")
      end
      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be 1-byte number from 300 to 9,999,999 ')
      end
      it '価格が全角文字では登録できない' do
        @item.price = 'わあお！'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be 1-byte number from 300 to 9,999,999 ')
      end
      it '価格が299円以下では登録できない' do
        @item.price = Faker::Number.within(range: 1..299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be 1-byte number from 300 to 9,999,999 ')
      end
      it '価格が10000000以上では登録できない' do
        @item.price = Faker::Number.between(from: 10_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be 1-byte number from 300 to 9,999,999 ')
      end

      it 'userが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
