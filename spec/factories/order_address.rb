FactoryBot.define do
  factory :order_address do
    building      { "ジブリモール坂本8296" }
    house_number  { "1-2-3" }
    municipality  { "札幌市どこかの町" }
    prefecture_id { "2" }
    postal_code   { "111-2345" }
    phone_number  { "08011223344" }
    token         { "tok_abcdefghijk12345678901234567" }
  
  end

end