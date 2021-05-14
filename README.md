# テーブル設計

## users テーブル

| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| nick_name             | string | null: false |
| email                 | string | null: false |
| encrypted_password    | string | null: false |
| family_name           | string | null: false |
| first_name            | string | null: false |
| family_name           | string | null: false |
| first_name            | string | null: false |
| data                  | date   | null: false |

### Association

- has_many :products
- has_many :purchase records
- has_many :shipping address

## products テーブル

| Column                         | Type       | Options           |
| ------------------------------ | ---------- | ----------------- |
| item_image                     | file       | null: false       |
| item_name                      | string     | null: false       |
| item_explain                   | text       | null: false       |
| item_category                  | select_box | null: false       |
| item_status                    | select_box | null: false       |
| item_shipping_free_status      | select_box | null: false       |
| item_prefecture                | select_box | null: false       |
| item_scheduled_delivery        | select_box | null: false       |
| price                          | integer    | null: false       |

### Association

- belongs_to :users
- has_many   :purchase records
- has_many   :shipping address

## purchase records テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| users     | references | foreign_key: true |
| products  | references | foreign_key: true |

### Association

- belongs_to :users
- belongs_to :products

## shipping address テーブル

| Column                | Type       | Options     |
| --------------------- | ---------- | ----------- |
| postal_code           | string     | null: false |
| prefectures           | select_box | null: false |
| city                  | string     | null: false |
| addresses             | string     | null: false |
| building              | string     | form_any    |
| phone_number          | integer    | null: false |

### Association

- belongs_to :users
