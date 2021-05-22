FactoryBot.define do
  factory :product do
    name { 'コート' }
    explain { 'コートです' }
    category_id { 2 }
    status_id { 2 }
    shipping_free_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 300 }
    association :user
    # image
    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

# | Column                         | Type       | Options           |
# | ------------------------------ | ---------- | ----------------- |
# | name                           | string     | null: false       |
# | explain                        | text       | null: false       |
# | category_id                    | integer    | null: false       |
# | status_id                      | integer    | null: false       |
# | shipping_free_status_id        | integer    | null: false       |
# | prefecture_id                  | integer    | null: false       |
# | scheduled_delivery_id          | integer    | null: false       |
# | price                          | integer    | null: false       |
# | user                           | references | foreign_key: true |
