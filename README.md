# DB設計
## users
| column                | type    | options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true |
| kanji_family_name     | string  | null: false               |
| kanji_first_name      | string  | null: false               |
| kana_family_name      | string  | null: false               |
| kana_first_name       | string  | null: false               |
| birthday_id           | date    | null: false               |
| encrypted_password    | string  | null: false               |

### association
- has_many :items
- has_many :orders

## items
| column        | type       | options                        |
| ------------- | ---------- | ------------------------------ |
| title         | string     | null: false                    |
| about         | text       | null: false                    |
| price         | integer    | null: false                    |
| charge_id     | integer    | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| till_id       | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_one :order

## orders
| column      | type       | options                        |
| ----------- | ---------- | ------------------------------ |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses
| column        | type       | options                        |
| ------------- | ---------- | ------------------------------ |
| building      | string     |                                |
| house_number  | string     | null: false                    |
| city-town     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| postal_code   | string     | null: false                    |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### association
- belongs_to :order