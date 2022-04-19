FactoryBot.define do
  factory :user do
    Faker::Config.locale = 'ja'
    gimei = Gimei.name
    nickname              {Faker::Name.initials(number: 2)}
    kanji_family_name     {gimei.last.kanji}
    kanji_first_name      {gimei.first.kanji}
    kana_family_name      {gimei.last.katakana}
    kana_first_name       {gimei.first.katakana}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2017-12-31')}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end