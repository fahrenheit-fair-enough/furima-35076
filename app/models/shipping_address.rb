class ShippingAddress < ApplicationRecord
  belongs_to :purchase_record
end




# README shipping address テーブル 参照に記入
# | Column                | Type       | Options           |
# | --------------------- | ---------- | ----------------- |
# | postal_code           | string     | null: false       |
# | prefecture_id         | integer    | null: false       |
# | city                  | string     | null: false       |
# | addresses             | string     | null: false       |
# | building              | string     |                   |
# | phone_number          | string     | null: false       |
# | purchase_record       | references | foreign_key: true |

## Association

# - belongs_to :purchase_record
