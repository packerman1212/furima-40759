# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association
- has_one :profile
- has_many :products
- has_many :orders


## profiles テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| last_name          | string     | null: false                    |
| first_name         | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| birth_date         | string     | null: false                    |

### Association
- belongs_to :user


## products テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :product_detail
- has_one :shipping
- has_one :order


## product_details テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| product          | references | null: false, foreign_key: true |
| category_id      | integer    | null: false                    |
| product_state_id | integer    | null: false                    |

### Association
- belongs_to :product
- belongs_to :category_id
- belongs_to :product_state_id

## shippings テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| product               | references | null: false, foreign_key: true |
| fee_responsibility_id | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| shipping_days_id      | integer    | null: false                    |

### Association
- belongs_to :product
- belongs_to :fee_responsibility_id
- belongs_to :prefecture_id
- belongs_to :shipping_days_id


## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| product | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association
- belongs_to :product
- belongs_to :user
- has_one :shipping_addresses


## shipping_addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| order         | references | null: false, foreign_key: true |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address1      | string     | null: false                    |
| address2      | string     |                                |
| phone_number  | string     | null: false                    |

### Association
- belongs_to :orders
- belongs_to :shipping_days_id


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
