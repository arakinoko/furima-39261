\# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |

has_many :items
has_many :orders
 


## destinations テーブル

| Column             | Type      | Options                        |
| ------------------ | --------- | ------------------------------ |
| postal_code        | string    | null: false                    |
| prefecture         | string    | null: false                    |
| city               | string    | null: false                    |
| address            | string    | null: false                    |
| building_name      | string    |                                |
| phone_number       | string    | null: false                    |
| order              | reference | null: false, foreign_key: true |


belongs_to :order

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| status        | references | null: false, foreign_key: true |
| postage       | references | null: false, foreign_key: true |
| prefecture    | references | null: false, foreign_key: true |
| shopping_date | references | null: false, foreign_key: true |
| price         | integer    | null: false                    |
| category      | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |

belongs_to :user 
has_one :order
belongs_to :status
belongs_to :postage
belongs_to :prefecture
belongs_to :shopping_date
belongs_to :category

## statuses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| status        | integer    | null: false                    |

has_many :items

## postages テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postage       | integer    | null: false                    |

has_many :items

## prefectures テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| prefecture    | integer    | null: false                    |

has_many :items

## shopping_dates テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| shopping_date | integer    | null: false                    |

has_many :items

## categories テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| category      | integer    | null: false                    |

has_many :items



## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

belongs_to :item
belongs_to :users
has_one :destination