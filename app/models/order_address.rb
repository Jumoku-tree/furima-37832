class OrderAddress
  include ActiveModel::Model
  attr_accessor :building, :house_number, :municipality, :prefecture_id, :postal_code, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :house_number
    validates :municipality
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "must include hyphen(-)" }
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: "must be without hypen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(house_number: house_number, municipality: municipality, postal_code: postal_code, phone_number: phone_number, prefecture_id: prefecture_id, order_id: order.id)
  end
end