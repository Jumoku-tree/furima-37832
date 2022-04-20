class Item < ApplicationRecord
  belongs_to :charge
  belongs_to :condition
  belongs_to :category
  belongs_to :till
  belongs_to :prefecture

  with_options presence: true do
    validates :title
    validates :about
    validates :user
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

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :charge
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :till
end
