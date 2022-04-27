class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :title
    validates :about
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'must be 1-byte number from 300 to 9,999,999 ' }
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :charge_id
    validates :category_id
    validates :condition_id
    validates :till_id
    validates :prefecture_id
  end

  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :charge
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :till
end
