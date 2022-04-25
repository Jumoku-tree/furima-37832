class Address < ApplicationRecord
  with_options presence: true do
    validates :house_number
    validates :municipality
    validates :postal_code    # バリデーションかける
    validates :phone_number   # バリデーションかける
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  belongs_to :order
end
