FactoryBot.define do
  factory :purchase_address do
    postal_code { '000-0000' }
    prefecture_id { 2 }
    city { '東京' }
    addresses { '東京' }
    phone_number { '00000000000' }
    building { '東京' }
    token { 'tok_14c225ef887eb46406cf5455648f1' }
  end
end

# 参照記述事項
# :postal_code, :prefecture_id, :city, :addresses, :phone_number,
