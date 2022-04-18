# DB設計
## users
| column                | type   | options     |
| --------------------- | ------ | ----------- |
| name                  | string | null: false |
| email                 | string | null: false |
| password              | string | null: false |
| password_confirmation | string | null: false |

### association
- has_many :items
- has_many :orders
- has_one :address

## items
| column    | type       | options                        |
| ----------| ---------- | ------------------------------ |
| title     | string     | null: false                    |
| price     | integer    | null: false                    |
| category  | text       | null: false                    |
| charge    | integer    | null: false                    |
| condition | text       | null: false                    |
| till      | date       | null: false                    |
| user      | references | null: false, foreign_key: true |
| addresses | references | null: false, foreign_key: true |

### association
- belongs_to :users
- has_one :orders

## orders
| column      | type       | options                        |
| ----------- | ---------- | ------------------------------ |
| order_date  | date       | null: false                    |
| buyer_user  | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |
| seller_user | references | null: false, foreign_key: true |
| addresses   | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses
| column      | type    | options     |
| ----------- | ------- | ----------- |
| room        | string  |             |
| number      | integer | null: false |
| city        | string  | null: false |
| prefecture  | string  | null: false |
| postal_code | integer | null: false |

### association
- belongs_to :users
- belongs_to :orders