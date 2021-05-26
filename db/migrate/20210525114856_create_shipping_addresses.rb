class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string              :postal_code,                    null: false
      t.integer             :prefecture_id,                  null: false
      t.string              :city,                           null: false
      t.string              :addresses,                      null: false
      t.string              :building                                  
      t.string              :phone_number,                   null: false
      t.references          :purchase_record,                foreign_key: true
      t.timestamps
    end
  end
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
