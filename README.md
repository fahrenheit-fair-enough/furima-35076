# テーブル設計

## users テーブル

| Column                | Type   | Options      |
| --------------------- | ------ | ------------ |
| nick_name             | string | null: false  |
| email                 | string | unique: true |
| encrypted_password    | string | null: false  |
| family_name           | string | null: false  |
| first_name            | string | null: false  |
| family_name_kana      | string | null: false  |
| first_name_kana       | string | null: false  |
| birth_date            | date   | null: false  |

### Association

- has_many :products
- has_many :purchase records
- has_many :shipping address

## products テーブル

| Column                         | Type       | Options           |
| ------------------------------ | ---------- | ----------------- |
| item_name                      | string     | null: false       |
| item_explain                   | text       | null: false       |
| item_category_id               | integer    | null: false       |
| item_status_id                 | integer    | null: false       |
| item_shipping_free_status_id   | integer    | null: false       |
| item_prefecture_id             | integer    | null: false       |
| item_scheduled_delivery_id     | integer    | null: false       |
| price                          | integer    | null: false       |

### Association

- belongs_to :user
- has_one    :purchase record
- has_many   :shipping address

## purchase records テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| user     | references | foreign_key: true |
| product  | references | foreign_key: true |

### Association

- belongs_to :user
- has_one    :product
- has_one    :shipping address

## shipping address テーブル

| Column                | Type       | Options     |
| --------------------- | ---------- | ----------- |
| postal_code           | string     | null: false |
| item_prefecture_id    | integer    | null: false |
| city                  | string     | null: false |
| addresses             | string     | null: false |
| building              | string     |             |
| phone_number          | string     | null: false |

### Association

- belongs_to :user
- has_one    :purchase record
