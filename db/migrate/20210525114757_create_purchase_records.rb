class CreatePurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_records do |t|
      t.references              :user,                    foreign_key: true
      t.references              :product,                    foreign_key: true
      t.timestamps
    end
  end
end



# README purchase records テーブル 参照に記入
# | Column    | Type       | Options           |
# | --------- | ---------- | ----------------- |
# | user      | references | foreign_key: true |
# | product   | references | foreign_key: true |

