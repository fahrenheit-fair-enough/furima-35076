class PurchaseRecord < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_address
end

# README purchase records テーブル 参照に記入
# | Column    | Type       | Options           |
# | --------- | ---------- | ----------------- |
# | user      | references | foreign_key: true |
# | product   | references | foreign_key: true |

### Association

# - belongs_to :user
# - belongs_to :product
# - has_one :shipping_address
