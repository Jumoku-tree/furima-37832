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
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  end

  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :charge_id
    validates :category_id
    validates :condition_id
    validates :till_id
    validates :prefecture_id
  end

  belongs_to :user
  belongs_to :category
  belongs_to :charge
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :till

end
