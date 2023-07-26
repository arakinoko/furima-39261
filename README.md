\# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

has_many :items
has_many :orders
has_many :destinations 
 


## destinations テーブル

| Column             | Type      | Options                        |
| ------------------ | --------- | ------------------------------ |
| family_name        | string    | null: false                    |
| first_name         | string    | null: false                    |
| family_name_kana   | string    | null: false                    |
| first_name_kana    | string    | null: false                    |
| postal_code        | string    | null: false                    |
| prefecture         | string    | null: false                    |
| city               | string    | null: false                    |
| address            | string    | null: false                    |
| building_name      | string    |                                |
| phone_number       | string    | null: false                    |
| user_id            | reference | null: false, foreign_key: true |

belongs_to :user
belongs_to :order

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| status        | integer    | null: false                    |
| postage       | integer    | null: false                    |
| region        | integer    | null: false                    |
| shopping_date | integer    | null: false                    |
| price         | integer    | null: false                    |
| category      | integer    | null: false                    |
| buyer_id      | references | null: false, foreign_key: true |
| user_id       | references | null: false, foreign_key: true |

belongs_to :user 
has_many :images 
has_one :order


## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| buyer_user_id | references | null: false, foreign_key: true |

belongs_to :item
has_many :users
has_one :destination