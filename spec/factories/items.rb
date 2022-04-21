FactoryBot.define do
  factory :item do
    title           {'aa'}
    about           {'aa'}
    price           {Faker::Number.within(range: 300..9999999)}
    image           {Faker::Lorem.sentence}
    category_id     { 3 }
    charge_id          { 3 }
    condition_id       { 3 }
    prefecture_id      { 3 }
    till_id            { 3 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
