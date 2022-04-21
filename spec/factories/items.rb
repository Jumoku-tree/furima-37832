FactoryBot.define do
  factory :item do
    title           {'aa'}
    about           {'aa'}
    price           {Faker::Number.within(range: 300..9999999)}
    category_id     { rand(2..11) }
    charge_id          { rand(2..3) }
    condition_id       { rand(2..7) }
    prefecture_id      { rand(7..48) }
    till_id            { rand(2..4) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
