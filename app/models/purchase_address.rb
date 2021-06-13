class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number,
                :purchase_record, :token

  with_options presence: true do
    validates :user_id
    validates :product_id

    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'をハイフンを加えて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :addresses
    validates :phone_number, length: { maximum: 11 }, numericality: true
    validates :token
  end

  def save
    # 購入記録を保存し、変数purchase recordsに代入する
    purchase_record = PurchaseRecord.create(user_id: user_id, product_id: product_id)
    # 発送先情報を保存する
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses,
                           building: building, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
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
