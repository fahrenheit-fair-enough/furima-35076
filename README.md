# テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| --------------------- | ------ | ------------------------- |
| nick_name             | string | null: false               |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| family_name           | string | null: false               |
| first_name            | string | null: false               |
| family_name_kana      | string | null: false               |
| first_name_kana       | string | null: false               |
| birth_date            | date   | null: false               |

### Association

- has_many :products
- has_many :purchase_records

## products テーブル

| Column                         | Type       | Options           |
| ------------------------------ | ---------- | ----------------- |
| name                           | string     | null: false       |
| explain                        | text       | null: false       |
| category_id                    | integer    | null: false       |
| status_id                      | integer    | null: false       |
| shipping_free_status_id        | integer    | null: false       |
| prefecture_id                  | integer    | null: false       |
| scheduled_delivery_id          | integer    | null: false       |
| price                          | integer    | null: false       |
| user                           | references | foreign_key: true |

### Association

- belongs_to :user
- has_one    :purchase_record

## purchase records テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| user      | references | foreign_key: true |
| product   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_address

## shipping address テーブル

| Column                | Type       | Options           |
| --------------------- | ---------- | ----------------- |
| postal_code           | string     | null: false       |
| prefecture_id         | integer    | null: false       |
| city                  | string     | null: false       |
| addresses             | string     | null: false       |
| building              | string     |                   |
| phone_number          | string     | null: false       |
| purchase_record       | references | foreign_key: true |

### Association

- belongs_to :purchase_record
